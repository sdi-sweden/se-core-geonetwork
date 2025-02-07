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

(function() {

  goog.provide('swe_search_config');

  var module = angular.module('swe_search_config',
      ['pascalprecht.translate']);
  //var module = angular.module('swe_search_config', []);


  module.run(['gnSearchSettings', 'gnViewerSettings',
    'gnOwsContextService', 'gnMap', 'gnSearchLocation',
    function(gnSearchSettings, gnViewerSettings,
             gnOwsContextService, gnMap, gnSearchLocation) {

      gnViewerSettings.defaultContext = null;

      // Keep one layer in the background
      // while the context is not yet loaded.
      gnViewerSettings.bgLayers = [
        gnMap.createLayerForType('osm')
      ];

      // add Swedish language to the datepicker
      $.fn.datepicker.dates['sv'] = {
        days:["Söndag","Måndag","Tisdag","Onsdag","Torsdag","Fredag","Lördag","Söndag"],
        daysShort:["Sön","Mån","Tis","Ons","Tor","Fre","Lör","Sön"],
        daysMin:["Sö","Må","Ti","On","To","Fr","Lö","Sö"],
        months:["Januari","Februari","Mars","April","Maj","Juni","Juli","Augusti","September","Oktober","November","December"],
        monthsShort:["Jan","Feb","Mar","Apr","Maj","Jun","Jul","Aug","Sep","Okt","Nov","Dec"],
        today:"Idag",
        format:"yyyy-mm-dd",
        weekStart:1,
        clear:"Rensa"
      };

      gnViewerSettings.servicesUrl =
          gnViewerSettings.mapConfig.listOfServices || {};

      // WMS settings
      gnViewerSettings.singleTileWMS = true;

      var bboxStyle = new ol.style.Style({
        stroke: new ol.style.Stroke({
          color: 'rgba(255,0,0,1)',
          width: 2
        }),
        fill: new ol.style.Fill({
          color: 'rgba(255,0,0,0.3)'
        })
      });
      gnSearchSettings.olStyles = {
        drawBbox: bboxStyle,
        mdExtent: new ol.style.Style({
          stroke: new ol.style.Stroke({
            color: 'orange',
            width: 2
          })
        }),
        mdExtentHighlight: new ol.style.Style({
          stroke: new ol.style.Stroke({
            color: 'orange',
            width: 3
          }),
          fill: new ol.style.Fill({
            color: 'rgba(255,255,0,0.3)'
          })
        })

      };

      // Object to store the current Map context
      gnViewerSettings.storage = 'sessionStorage';

      var extent = [-1200000, 4700000, 2540000, 8500000];

      proj4.defs(
          'EPSG:3006',
          '+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 ' +
          '+units=m +axis=neu +no_defs');
      ol.proj.get('EPSG:3006').setExtent(extent);
      ol.proj.get('EPSG:3006').setWorldExtent([-5.05651650131, 40.6662879582,
        28.0689828648, 71.7832476487]);

      proj4.defs('urn:ogc:def:crs:EPSG::3006', proj4.defs('EPSG:3006'));
      proj4.defs('http://www.opengis.net/gml/srs/epsg.xml#3006', proj4.defs('EPSG:3006'));

      var projection = ol.proj.get('EPSG:3006');

      // MapFish requires absolute path to topoweb service
      var topoWmsUrl = gnSearchLocation.appUrl() + '/topo-wms';
      
      
      var wms = [new ol.layer.Tile({
    	  group: 'Background layers',
    	  crossOrigin: 'anonymous',
    	  url: topoWmsUrl,
          source: new ol.source.TileWMS({
        	  url: topoWmsUrl,
              params: {
                  FORMAT: 'image/png',
                  VERSION: '1.1.1',
                  SRS: 'EPSG:3006',
                  LAYERS: 'topowebbkartan'
              }
          })
      })];


      /*******************************************************************
       * Define maps
       */
      var mapsConfig = {
        extent: extent,
        projection: projection,
        center: [572087, 6802255],
        maxZoom: 28,
        minZoom: 2,
        zoom: 2
      };

      // Add backgrounds to TOC
      gnViewerSettings.bgLayers = wms;
      gnViewerSettings.servicesUrl = {};
      
      var viewerMap = new ol.Map({
        controls: [],
        view: new ol.View(mapsConfig)
      });

      var searchMap = new ol.Map({
        controls:[],
        view: new ol.View(mapsConfig)
      });


      /** Facets configuration */
      gnSearchSettings.facetsSummaryType = 'swe-details';

      /*
       * Hits per page combo values configuration. The first one is the
       * default.
       */
      gnSearchSettings.hitsperpageValues = [20, 50, 100];

      /* Pagination configuration */
      gnSearchSettings.paginationInfo = {
        hitsPerPage: gnSearchSettings.hitsperpageValues[0]
      };

      // after sorting the results go back to the first page of results (with from & to)
      gnSearchSettings.sortbyValues = [{
          sortBy: 'relevance',
          sortOrder: '',
          from: 1,
          to: gnSearchSettings.hitsperpageValues[0]
      }, {
        sortBy: 'changeDate',
        sortOrder: '',
        from: 1,
        to: gnSearchSettings.hitsperpageValues[0]
      }, {
        sortBy: 'title',
        sortOrder: 'reverse',
        from: 1,
        to: gnSearchSettings.hitsperpageValues[0]
      }];

      /* Default search by option */
      gnSearchSettings.sortbyDefault = gnSearchSettings.sortbyValues[0];

      gnSearchSettings.resultTemplate = '../../catalog/views/swe/' +
          'templates/resultList.html';

      // Mapping for md links in search result list.
      gnSearchSettings.linkTypes = {
        //links: ['LINK', 'kml'],
        links: ['HTTP:Information'],
        downloads: ['HTTP:Nedladdning', 'HTTP:OGC:WFS', 'HTTP:OGC:API-Features','HTTP:REST:API'],
        //layers:['OGC', 'kml'],
        layers: ['HTTP:OGC:WMS', 'HTTP:OGC:API-Maps'],
        maps: ['ows']
      };

      // Set custom config in gnSearchSettings
      angular.extend(gnSearchSettings, {
        viewerMap: viewerMap,
        searchMap: searchMap
      });
    }
  ]);


  /*module.config(['$LOCALES', function($LOCALES) {
    $LOCALES.push('../../catalog/views/swe/locales/|search');
  }]);*/

  module.config(['$LOCALES', function($LOCALES) {
    $LOCALES.push('../../catalog/views/swe/locales/|search');
    $LOCALES.push('/../api/0.1/standards/iso19139.swe/' +
        'codelists/gmd%3ACI_RoleCode');
    $LOCALES.push('/../api/0.1/standards/iso19139.swe/' +
        'codelists/gmd%3ACI_DateTypeCode');

  }]);

})();
