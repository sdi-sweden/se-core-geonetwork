/*
 * Copyright (C) 2001-2016 Food and Agriculture Organization of the
 * United Nations (FAO-UN), United Nations World Food Programme (WFP)
 * and United Nations Environment Programme (UNEP)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 *
 * Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
 * Rome - Italy. email: geonetwork@osgeo.org
 */

package org.fao.geonet.api.records;

import static org.fao.geonet.api.ApiParams.API_CLASS_RECORD_OPS;
import static org.fao.geonet.api.ApiParams.API_CLASS_RECORD_TAG;
import static org.fao.geonet.api.ApiParams.API_PARAM_RECORD_UUID;
import static org.fao.geonet.api.records.formatters.XsltFormatter.getSchemaLocalization;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.fao.geonet.ApplicationContextHolder;
import org.fao.geonet.api.API;
import org.fao.geonet.api.ApiParams;
import org.fao.geonet.api.ApiUtils;
import org.fao.geonet.api.records.editing.AjaxEditUtils;
import org.fao.geonet.api.records.model.validation.Reports;
import org.fao.geonet.api.tools.i18n.LanguageUtils;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.domain.Metadata;
import org.fao.geonet.domain.Schematron;
import org.fao.geonet.exceptions.BadParameterEx;
import org.fao.geonet.kernel.DataManager;
import org.fao.geonet.kernel.GeonetworkDataDirectory;
import org.fao.geonet.kernel.schema.MetadataSchema;
import org.fao.geonet.kernel.setting.SettingManager;
import org.fao.geonet.repository.SchematronRepository;
import org.fao.geonet.utils.IO;
import org.fao.geonet.utils.Xml;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.filter.ElementFilter;
import org.jdom.input.SAXBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.google.common.collect.Lists;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import jeeves.server.context.ServiceContext;
import jeeves.services.ReadWriteController;
import springfox.documentation.annotations.ApiIgnore;

@RequestMapping(value = {
    "/api/records",
    "/api/" + API.VERSION_0_1 +
        "/records"
})
@Api(value = API_CLASS_RECORD_TAG,
    tags = API_CLASS_RECORD_TAG,
    description = API_CLASS_RECORD_OPS)
@Controller("recordValidate")
@PreAuthorize("hasRole('Editor')")
@ReadWriteController
public class MetadataValidateApi {

    @Autowired
    LanguageUtils languageUtils;


    @ApiOperation(
        value = "Validate a record",
        notes = "User MUST be able to edit the record to validate it. " +
            "FIXME : id MUST be the id of the current metadata record in session ?",
        nickname = "validate")
    @RequestMapping(value = "/{metadataUuid}/validate",
        method = RequestMethod.PUT,
        produces = {
            MediaType.APPLICATION_JSON_VALUE,
            MediaType.APPLICATION_XML_VALUE
        }
    )
    @ResponseStatus(HttpStatus.CREATED)
    @PreAuthorize("hasRole('Editor')")
    @ApiResponses(value = {
        @ApiResponse(code = 201, message = "Validation report."),
        @ApiResponse(code = 403, message = ApiParams.API_RESPONSE_NOT_ALLOWED_CAN_EDIT)
    })
    public
    @ResponseBody
    Reports validateRecord(
        @ApiParam(
            value = API_PARAM_RECORD_UUID,
            required = true)
        @PathVariable
            String metadataUuid,
        HttpServletRequest request,
        @ApiParam(hidden = true)
        @ApiIgnore
            HttpSession session
    )
        throws Exception {
        Metadata metadata = ApiUtils.canEditRecord(metadataUuid, request);
        ApplicationContext appContext = ApplicationContextHolder.get();
        ServiceContext context = ApiUtils.createServiceContext(request);
        DataManager dataManager = appContext.getBean(DataManager.class);

        String id = String.valueOf(metadata.getId());
        String schemaName = dataManager.getMetadataSchema(id);

        Locale locale = languageUtils.parseAcceptLanguage(request.getLocales());

        //--- validate metadata from session
        Element errorReport;
        try {
            errorReport = new AjaxEditUtils(context)
                .validateMetadataEmbedded(
                    ApiUtils.getUserSession(session),
                    id,
                    locale.getISO3Language());
        } catch (NullPointerException e) {
            // TODO: Improve NPE catching exception
            throw new BadParameterEx(String.format(
                "To validate a record, the record MUST be in edition."),
                metadataUuid);
        }

        restructureReportToHavePatternRuleHierarchy(errorReport);

        //--- update element and return status
        Element elResp = new Element("root");
        elResp.addContent(new Element(Geonet.Elem.ID).setText(id));
        elResp.addContent(new Element("language").setText(locale.getISO3Language()));
        elResp.addContent(new Element("schema").setText(dataManager.getMetadataSchema(id)));
        elResp.addContent(errorReport);
        Element schematronTranslations = new Element("schematronTranslations");

        final SchematronRepository schematronRepository = context.getBean(SchematronRepository.class);
        // --- add translations for schematrons
        final List<Schematron> schematrons = schematronRepository.findAllBySchemaName(schemaName);

        MetadataSchema metadataSchema = dataManager.getSchema(schemaName);
        Path schemaDir = metadataSchema.getSchemaDir();
        SAXBuilder builder = new SAXBuilder();

        for (Schematron schematron : schematrons) {
            // it contains absolute path to the xsl file
            String rule = schematron.getRuleName();

            Path file = schemaDir.resolve("loc").resolve(locale.getISO3Language()).resolve(rule + ".xml");

            Document document;
            if (Files.isRegularFile(file)) {
                try (InputStream in = IO.newInputStream(file)) {
                    document = builder.build(in);
                }
                Element element = document.getRootElement();

                Element s = new Element(rule);
                element.detach();
                s.addContent(element);
                schematronTranslations.addContent(s);
            }
        }
        elResp.addContent(schematronTranslations);

        // TODO: Avoid XSL
        GeonetworkDataDirectory dataDirectory = context.getBean(GeonetworkDataDirectory.class);
        Path validateXsl = dataDirectory.getWebappDir().resolve("xslt/services/metadata/validate.xsl");
        Map<String, Object> params = new HashMap<>();
        params.put("rootTag", "reports");
        List<Element> elementList = getSchemaLocalization(
            metadata.getDataInfo().getSchemaId(), locale.getISO3Language());
        for (Element e : elementList) {
            elResp.addContent(e);
        }
        final Element transform = Xml.transform(elResp, validateXsl, params);

        Reports response = (Reports) Xml.unmarshall(transform, Reports.class);

        return response;
    }

    public static final String EL_ACTIVE_PATTERN = "active-pattern";
    public static final String EL_FIRED_RULE = "fired-rule";
    public static final String EL_FAILED_ASSERT = "failed-assert";
    public static final String EL_SUCCESS_REPORT = "successful-report";
    public static final String ATT_CONTEXT = "context";
    public static final String DEFAULT_CONTEXT = "??";
    public static final String INSPIRE_URL = "metadata/validator/inspireUrl";
    public static final String INSPIRE_XML = "metadata/validator/inspireXml";
    public static final String MDRELATION_URL = "metadata/validator/mdrelationUrl";
    public static final String MDRELATION_XML = "metadata/validator/mdrelationXml";
    public static final String INPUTMETADATAXML = "INPUTMETADATAXML";
    public static final String GMD_COLON_MD_METADATA= "gmd:MD_Metadata";
    public static final String REQUEST_XML = "requestXML";
    public static final String HTML_RESPONSE = "htmlResponse";
    public static final String UTF_8 = "UTF-8";
    public static final String LINE_SEPARATOR = "line.separator";
    public static final String VALIDATE_MDRELATION_VALUE = "Validate a record for MDRelation";
    public static final String VALIDATE_MDRELATION_MESSAGE = "Validation report for MD Relation";
    public static final String VALIDATE_MDRELATION_NICKNAME = "validateformdrelation";
    public static final String VALIDATE_MDRELATION_NOTE = "User MUST be able to edit the record to validate it. ";
    public static final String VALIDATE_INSPIRE_VALUE = "Validate a record for Inspire";
    public static final String VALIDATE_INSPIRE_MESSAGE = "Validation report for Inspire";
    public static final String VALIDATE_INSPIRE_NICKNAME = "validateforinspire";
    public static final String VALIDATE_INSPIRE_NOTE = "User MUST be able to edit the record to validate it. ";
    /**
     * Schematron report has an odd structure:
     * <pre><code>
     * &lt;svrl:active-pattern  ... />
     * &lt;svrl:fired-rule  ... />
     * &lt;svrl:failed-assert ... />
     * &lt;svrl:successful-report ... />
     * </code></pre>
     * <p/>
     * This method restructures the xml to be:
     * <pre><code>
     * &lt;svrl:active-pattern  ... >
     *     &lt;svrl:fired-rule  ... >
     *         &lt;svrl:failed-assert ... />
     *         &lt;svrl:successful-report ... />
     *     &lt;svrl:fired-rule  ... >
     * &lt;svrl:active-pattern>
     * </code></pre>
     */
    public static void restructureReportToHavePatternRuleHierarchy(Element errorReport) {
        final Iterator patternFilter = errorReport.getDescendants(new ElementFilter(EL_ACTIVE_PATTERN, Geonet.Namespaces.SVRL));
        @SuppressWarnings("unchecked")
        List<Element> patterns = Lists.newArrayList(patternFilter);
        for (Element pattern : patterns) {
            final Element parentElement = pattern.getParentElement();
            Element currentRule = null;
            @SuppressWarnings("unchecked")
            final List<Element> children = parentElement.getChildren();

            int index = children.indexOf(pattern) + 1;
            while (index < children.size() && !children.get(index).getName().equals(EL_ACTIVE_PATTERN)) {
                Element next = children.get(index);
                if (EL_FIRED_RULE.equals(next.getName())) {
                    currentRule = next;
                    next.detach();
                    pattern.addContent(next);
                } else {
                    if (currentRule == null) {
                        // odd but could happen I suppose
                        currentRule = new Element(EL_FIRED_RULE, Geonet.Namespaces.SVRL).
                            setAttribute(ATT_CONTEXT, DEFAULT_CONTEXT);
                        pattern.addContent(currentRule);
                    }

                    next.detach();
                    currentRule.addContent(next);

                }
            }
            if (pattern.getChildren().isEmpty()) {
                pattern.detach();
            }
        }
    }
    
    @ApiOperation(
            value = VALIDATE_INSPIRE_VALUE,
            notes = VALIDATE_INSPIRE_NOTE,
            nickname = VALIDATE_INSPIRE_NICKNAME)
        @RequestMapping(value = "/{metadataUuid}/validate/inspire",
            method = RequestMethod.POST,
            produces = {
                MediaType.APPLICATION_JSON_VALUE
            }
        )
        @ResponseStatus(HttpStatus.OK)
        @PreAuthorize("hasRole('Editor')")
        @ApiResponses(value = {
            @ApiResponse(code = 201, message = VALIDATE_INSPIRE_MESSAGE),
            @ApiResponse(code = 403, message = ApiParams.API_RESPONSE_NOT_ALLOWED_CAN_EDIT)
        })
        public
        @ResponseBody
        Map<String, Object> validateRecordForInspire(
            @ApiParam(
                value = API_PARAM_RECORD_UUID,
                required = true)
            @PathVariable
                String metadataUuid,
            HttpServletRequest request,
            @ApiParam(hidden = true)
            @ApiIgnore
                HttpSession session
        )
            throws Exception {
            Metadata metadata = ApiUtils.canEditRecord(metadataUuid, request);
            String xmlString = metadata.getData();
            String URLforValidation = null; //"https://www.geodata.se/InspireValidation/Service"; // Don't hard code here.
            ApplicationContext applicationContext = ApplicationContextHolder.get();
            SettingManager sm = applicationContext.getBean(SettingManager.class);
            URLforValidation = sm.getValue(INSPIRE_URL);
            String XMLforValidation = null; //"<?xml version=\"1.0\" encoding=\"UTF-8\"?><INSPIREVALIDATION><SCANMODE>METADATA</SCANMODE><SCANDETAILS><METADATAXML><![CDATA[INPUTMETADATAXML]]></METADATAXML></SCANDETAILS><SCANFORSERVICE>true</SCANFORSERVICE><OUTPUTFORMAT>html</OUTPUTFORMAT></INSPIREVALIDATION>";
            XMLforValidation = sm.getValue(INSPIRE_XML);
            if(xmlString != null && xmlString.contains(GMD_COLON_MD_METADATA)) {
            	XMLforValidation = XMLforValidation.replace(INPUTMETADATAXML, xmlString);
            }
            PostMethod post = new PostMethod(URLforValidation);    
		    post.addParameter(REQUEST_XML, XMLforValidation);
		    
		    HttpClient httpClient = new HttpClient();			    
		    httpClient.executeMethod(post);
		    String inspireHtmlResponse = null;
		    if(post.getStatusCode() ==  org.apache.commons.httpclient.HttpStatus.SC_OK){
		    	inspireHtmlResponse = MetadataValidateApi.getPostResponseAsString(post);
		    	if(inspireHtmlResponse != null) {
		    		inspireHtmlResponse = inspireHtmlResponse.replaceAll("&amp;", "&");
		    	}
		    }
		    Map<String, Object> responseMap = new HashMap<String, Object>();
		    responseMap.put(HTML_RESPONSE, inspireHtmlResponse);
            return responseMap;
        }
    
    @ApiOperation(
            value = VALIDATE_MDRELATION_VALUE,
            notes = VALIDATE_MDRELATION_NOTE,
            nickname = VALIDATE_MDRELATION_NICKNAME)
        @RequestMapping(value = "/{metadataUuid}/validate/mdrelation",
            method = RequestMethod.POST,
            produces = {
                MediaType.APPLICATION_JSON_VALUE
            }
        )
        @ResponseStatus(HttpStatus.OK)
        @PreAuthorize("hasRole('Editor')")
        @ApiResponses(value = {
            @ApiResponse(code = 201, message = VALIDATE_MDRELATION_MESSAGE),
            @ApiResponse(code = 403, message = ApiParams.API_RESPONSE_NOT_ALLOWED_CAN_EDIT)
        })
        public
        @ResponseBody
        Map<String, Object> validateRecordForMDRelation(
            @ApiParam(
                value = API_PARAM_RECORD_UUID,
                required = true)
            @PathVariable
                String metadataUuid,
            HttpServletRequest request,
            @ApiParam(hidden = true)
            @ApiIgnore
                HttpSession session
        )
            throws Exception {
            Metadata metadata = ApiUtils.canEditRecord(metadataUuid, request);
            String xmlString = metadata.getData();
            String URLforValidation = null; //"https://www.geodata.se/MDRelationCheck/Service"; // Don't hard code here.
            ApplicationContext applicationContext = ApplicationContextHolder.get();
            SettingManager sm = applicationContext.getBean(SettingManager.class);
            URLforValidation = sm.getValue(MDRELATION_URL);
            String XMLforValidation = null; //"<?xml version=\"1.0\" encoding=\"UTF-8\"?><CSWQualityCheck><SCANMODE>METADATA</SCANMODE><SCANDETAILS><METADATAXML><![CDATA[INPUTMETADATAXML]]></METADATAXML></SCANDETAILS></CSWQualityCheck>";
            XMLforValidation = sm.getValue(MDRELATION_XML);
            if(xmlString != null && xmlString.contains(GMD_COLON_MD_METADATA)) {
            	XMLforValidation = XMLforValidation.replace(INPUTMETADATAXML, xmlString);
            }
            PostMethod post = new PostMethod(URLforValidation);    
		    post.addParameter(REQUEST_XML, XMLforValidation);
		    
		    HttpClient httpClient = new HttpClient();			    
		    httpClient.executeMethod(post);
		    String mdRelationHtmlResponse = null;
		    if(post.getStatusCode() ==  org.apache.commons.httpclient.HttpStatus.SC_OK){
		    	mdRelationHtmlResponse = MetadataValidateApi.getPostResponseAsString(post);
		    	if(mdRelationHtmlResponse != null) {
		    		mdRelationHtmlResponse = mdRelationHtmlResponse.replaceAll("&amp;", "&");
		    	}
		    }
		    Map<String, Object> responseMap = new HashMap<String, Object>();
		    responseMap.put(HTML_RESPONSE, mdRelationHtmlResponse);
            return responseMap;
        }
    
		private static String getPostResponseAsString(PostMethod post) throws Exception {
			BufferedReader br = new BufferedReader(new InputStreamReader(post.getResponseBodyAsStream(), UTF_8));
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
				sb.append(System.getProperty(LINE_SEPARATOR));
			}
			return sb.toString();
		}
}
