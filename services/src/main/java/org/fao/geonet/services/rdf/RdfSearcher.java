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

package org.fao.geonet.services.rdf;

import jeeves.server.ServiceConfig;
import jeeves.server.context.ServiceContext;

import org.apache.commons.lang.StringUtils;
import org.fao.geonet.GeonetContext;
import org.fao.geonet.Util;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.constants.Params;
import org.fao.geonet.kernel.search.MetaSearcher;
import org.fao.geonet.kernel.search.SearchManager;
import org.fao.geonet.kernel.search.SearcherType;
import org.fao.geonet.services.util.SearchDefaults;
import org.fao.geonet.utils.Log;
import org.fao.geonet.utils.Xml;
import org.jdom.Element;

import java.util.List;

/**
 * Class to search with the lucene searcher all public metadata that fits the user filter. Used by
 * RDF harvest service to return all the public metadata from the catalogue in rdf format.
 *
 * @author Jose García
 */
public class RdfSearcher {
    private MetaSearcher searcher;
    private Element searchRequest;
    private String organisation;

    public String getOrganisation() {
        return organisation;
    }

    public RdfSearcher(Element params, ServiceContext context) {
        searchRequest = SearchDefaults.getDefaultSearch(context, params);
        searchRequest.addContent(new Element(Geonet.SearchResult.BUILD_SUMMARY).setText("false"));
        searchRequest.addContent(new Element("_isTemplate").setText("n"));

        searchRequest.addContent(new Element("_op0").setText("1"));

        String initiativKeyword = Util.getParam(params, "initiativKeyword", "");
        if (StringUtils.isNotEmpty(initiativKeyword)) {
            searchRequest.addContent(new Element("initiativKeyword").setText(initiativKeyword));
        }

        organisation = Util.getParam(params, "orgName", "");

        if (Log.isDebugEnabled(Geonet.SEARCH_ENGINE))
            Log.debug(Geonet.SEARCH_ENGINE, "PUBLIC METADATA SEARCH CRITERIA:\n" + Xml.getString(searchRequest));

    }

    public List search(ServiceContext context) throws Exception {
        GeonetContext gc = (GeonetContext) context.getHandlerContext(Geonet.CONTEXT_NAME);
        SearchManager searchMan = gc.getBean(SearchManager.class);
        searcher = searchMan.newSearcher(SearcherType.LUCENE, Geonet.File.SEARCH_LUCENE);

        ServiceConfig config = new ServiceConfig();

        searcher.search(context, searchRequest, config);

        Element presentRequest = new Element("request");
        presentRequest.addContent(new Element("fast").setText("true"));
        presentRequest.addContent(new Element("from").setText("1"));
        presentRequest.addContent(new Element("to").setText(searcher.getSize() + ""));
        presentRequest.addContent(new Element(Geonet.SearchResult.FAST).setText("true"));
        presentRequest.addContent(new Element(Geonet.SearchResult.BUILD_SUMMARY).setText("false"));

        return searcher.present(context, presentRequest, config).getChildren();
    }

    public void close() {
        try {
            if (searcher != null) searcher.close();
        } catch (Exception ex) {
            // Ignore exception
        }
    }
}
