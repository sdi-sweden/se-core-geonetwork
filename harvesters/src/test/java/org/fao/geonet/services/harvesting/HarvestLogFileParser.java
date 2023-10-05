package org.fao.geonet.services.harvesting;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.LineIterator;
import org.apache.commons.lang.StringUtils;
import org.junit.Ignore;
import org.junit.Test;

public class HarvestLogFileParser {

//	@Test
	@Ignore
	public void parseLogFile() throws IOException {

	    String path = "C:\\tmp\\harvester_csw_Naturv_rdsverket_202310050846.log";
//	    String path = "C:\\tmp\\harvester_csw_Naturv_rdsverket_201902010500.log";
	    File theFile = FileUtils.getFile(path);
	    LineIterator it = FileUtils.lineIterator(theFile, "UTF-8");
	    Integer lineCount = 0;
	    Integer errorCount = 0;
	    String ruleSet = "";
	    boolean findErrorMsg = false;
	    System.out.println("Start parsing log file for schematron errors " + path);
	    try {
	        while (it.hasNext()) {
	            String line = it.nextLine();
	            lineCount++;
	            boolean svf = isSchematronValidationFail(line);
	            if (svf) {
	            	errorCount++;
	            	String uuid = getUUIDFromLine(line);
	            	System.out.println("Found Schematron Validation Failure for " + uuid);
	            	findErrorMsg = true;	            	
	            }
	            if (findErrorMsg) {
	            	if(lineContainsRuleHeader(line)) {
	            	  ruleSet = getRuleSetName(line);
	            	}
	            	if (lineContainsErrorMsg(line)) {
	            		if (StringUtils.isNotEmpty(ruleSet)) {
	            			System.out.println("Schematron Rule Set = " + ruleSet);
	            		}
	            		printErrorMsg(line);
	            	}
	            }
	            if (endOfErrorMsgsForRecord(line)) {
	            	findErrorMsg = false;
	            	System.out.println("");
	            }
	        }
	    } finally {
	        LineIterator.closeQuietly(it);
	    }
	 System.out.println("Line Count = " + lineCount);
	 System.out.println("Schematron Validation Failure count = " + errorCount);
	    
	}

	private boolean endOfErrorMsgsForRecord(String line) {
		if (StringUtils.contains(line, "</geonet:schematronerrors> for more details")) {
			return true;
		}
		return false;
	}

	private void printErrorMsg(String line) {
//        Integer msgStartPos = StringUtils.indexOf(line, "<svrl:text>");
//        Integer msgEndPos = StringUtils.indexOf(line, "</svrl:text>");
		String msg = StringUtils.substringBetween(line, "<svrl:text>", "</svrl:text>");
		System.out.println(msg);
	}

    private String getRuleSetName(String line) {
//        Integer msgStartPos = StringUtils.indexOf(line, "title=");
//        Integer msgEndPos = StringUtils.indexOf(line, " schemaVersion=");
		String msg = StringUtils.substringBetween(line, "title=", " schemaVersion=");
		if (StringUtils.isNotEmpty(msg)) {
		    return msg;
		} else {
			return "";
		}
    }
    
	private boolean lineContainsRuleHeader(String line) {
		if(StringUtils.contains(line, "<svrl:schematron-output")) {
        	return true;
        }
		return false;
	}
	
	private boolean lineContainsErrorMsg(String line) {
        if(StringUtils.contains(line, "<svrl:text>")) {
        	return true;
        }
		return false;
	}

	private String getUUIDFromLine(String line) {
        Integer uuidPos = StringUtils.indexOf(line, "uuid");
        return StringUtils.substring(line, uuidPos+5);
	}

	private boolean isSchematronValidationFail(String line) {
        if (line.contains("(Schematron Validation fail)")) {
        	return true;
        }
		return false;
	}
	
	
}
