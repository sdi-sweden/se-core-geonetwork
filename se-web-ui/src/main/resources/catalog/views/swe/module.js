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

  goog.provide('gn_search_swe');






  goog.require('cookie_warning');
  goog.require('gn_related_directive');
  goog.require('gn_resultsview');
  goog.require('gn_search');
  goog.require('swe_directives');
  goog.require('swe_search_config');

  var module = angular.module('gn_search_swe', [
    'gn_related_directive', 'gn_search',
    'gn_resultsview', 'cookie_warning',
    'swe_search_config', 'swe_directives', 'ngStorage',
    'angulartics', 'angulartics.piwik', 'angulartics.debug']);

  module.controller('gnsSwe', [
    '$rootScope',
    '$scope',
    '$localStorage',
    '$location',
    '$analytics',
    'suggestService',
    '$http',
    '$sce',
    '$compile',
    '$window',
    '$translate',
    '$timeout',
    'gnUtilityService',
    'gnSearchSettings',
    'gnViewerSettings',
    'gnMap',
    'gnMdView',
    'gnMdViewObj',
    'gnWmsQueue',
    'gnSearchLocation',
    'gnOwsContextService',
    'hotkeys',
    'gnGlobalSettings',
    'gnMdFormatter',
    'gnConfig',
    'gnConfigService',
    'is_map_maximized',
    'exampleResize',
    'shareGnMainViewerScope',
    function($rootScope, $scope, $localStorage, $location, $analytics, suggestService,
             $http, $sce, $compile, $window, $translate, $timeout,
             gnUtilityService, gnSearchSettings, gnViewerSettings,
             gnMap, gnMdView, mdView, gnWmsQueue,
             gnSearchLocation, gnOwsContextService,
             hotkeys, gnGlobalSettings, gnMdFormatter, gnConfig, gnConfigService, is_map_maximized, exampleResize, shareGnMainViewerScope) {

      var viewerMap = gnSearchSettings.viewerMap;
      var searchMap = gnSearchSettings.searchMap;

      $scope.displayInitialMetadata = false;

      $scope.vectorLayer = new ol.layer.Vector({
        source: new ol.source.Vector({
          features: []
        }),
        style: gnSearchSettings.olStyles.mdExtentHighlight,
        map: searchMap
      });


      $scope.vectorLayerBM = new ol.layer.Vector({
        source: new ol.source.Vector({
          features: []
        }),
        style: gnSearchSettings.olStyles.mdExtentHighlight,
        map: viewerMap
      });
      $scope.viewMode = 'full';

      $scope.formatter = gnSearchSettings.formatter;
      $scope.modelOptions = angular.copy(gnGlobalSettings.modelOptions);
      $scope.modelOptionsForm = angular.copy(gnGlobalSettings.modelOptions);
      $scope.modelOptionsFormGeo = angular.copy(gnGlobalSettings.modelOptions);
      $scope.gnWmsQueue = gnWmsQueue;
      $scope.$location = $location;
      $scope.activeTab = '/search';
      $scope.resultTemplate = gnSearchSettings.resultTemplate;
      $scope.facetsSummaryType = gnSearchSettings.facetsSummaryType;
      $scope.location = gnSearchLocation;

      gnConfigService.loadPromise.then(function() {
        $scope.predefinedMapsUrl = '../../' + gnGlobalSettings.srvProxyUrl +
            gnConfig['map.predefinedMaps.url'];

        $scope.geotechnicsUrl = '../../' + gnGlobalSettings.srvProxyUrl +
            gnConfig['map.geotechnics.url'];
      });

      $scope.selectedPredefinedMap = gnGlobalSettings.predefinedSelectedMap;
      if ($scope.selectedPredefinedMap) {
        // Clean owsContext to load only the layers from the predefined map
        // It's already done in the directive, but seem in no debug mode it's "too late"
        // to do it in the directive
        var storage = gnViewerSettings.storage ?
          window[gnViewerSettings.storage] : window.localStorage;

        storage.removeItem('owsContext');
      }
      $scope.collapsed = false;
      $scope.mapFullView = false;
      $scope.$on('someEvent', function(event, map) {
        alert('event received. url is: ' + map.url);

      });

      $scope.$on('search', function() {
        $scope.triggerSearch();
      });

     $scope.$on('aftersearchemptyorerror', function() {
       if ($scope.displayInitialMetadata) {
         $scope.displayInitialMetadata = false;
         $scope.displayInitialMetadataUUID = "";
       }
     });

      $scope.$on('aftersearch', function() {
    	  if ($scope.displayInitialMetadata) {
    		 if (($scope.mdView.current.record) &&
    		    ($scope.mdView.current.record.getUuid() ==  $scope.displayInitialMetadataUUID)) {
    		       $scope.displayInitialMetadata = false;
    		       $scope.displayInitialMetadataUUID = "";

    		       var checkExist = setInterval(function() {
    		         if ($('.geodata-row-popup').length) {
    		           $scope.showMetadata($scope.mdView.current.index,
    		              $scope.mdView.current.record,
    		              $scope.mdView.records);
    		           clearInterval(checkExist);
    		         }
    		       }, 100);
    		   }
    	  }

//    	  $analytics.eventTrack('siteSearch', {  searchQuery: $location.search(),
//              searchQueryResult: ($scope.searchResults.count > 0)?'hit':'no-hit' });
    	  
    	  // look at $location.search() to see what type of search was made
    	  //   free text: $location.search().or is not null
    	  //   dataset: type = "dataset or series"
    	  //   map-services: dynamic = true
    	  //   download: download = true
    	  //   advanced search: facet.q = {orgNameOwner|topicCat|initiativKeyword}
    	  //   favorite: none of the above
    	  //   extra information:
    	  //      from:
    	  //      to:
    	  //      sortby:
    	  
    	  //  $analytics.eventTrack('eventName', {  category: 'category', label: 'label' });
    	  //  $analytics.trackSiteSearch(keyword, [category], [count])
    	  if ($location.search().or) {
    	      $analytics.eventTrack('Fritextsök', { category: 'SiteSearch', label: $location.search().or + ' : ' + ($scope.searchResults.count > 0)?'hit':'no-hit' });
         	  $analytics.trackSiteSearch($location.search().or, 'FreetextSearch', $scope.searchResults.count);
    	  }
    	  if ($location.search().type) {
    		  $analytics.eventTrack('Filtreringsök', { category: 'SiteSearch', label: 'dataset/series' + ' : ' + ($scope.searchResults.count > 0)?'hit':'no-hit' });
         	  $analytics.trackSiteSearch('dataset/series', 'FilterSearch', $scope.searchResults.count);
    	  }
    	  if ($location.search().dynamic) {
     		  $analytics.eventTrack('Filtreringsök', { category: 'SiteSearch', label: 'mapservices' + ' : ' + ($scope.searchResults.count > 0)?'hit':'no-hit' });
         	  $analytics.trackSiteSearch('map services', 'FilterSearch', $scope.searchResults.count);
     	  }
    	  if ($location.search().download) {
      		  $analytics.eventTrack('Filtreringsök', { category: 'SiteSearch', label: 'download' + ' : ' + ($scope.searchResults.count > 0)?'hit':'no-hit' });
         	  $analytics.trackSiteSearch('download services', 'FilterSearch', $scope.searchResults.count);
      	  }
    	  if ("facet.q" in $location.search()) {
    		  var facet = searchObj["facet.q"];
     		  $analytics.eventTrack('Advanceradsök', { category: 'SiteSearch', label: facet + ' : ' + ($scope.searchResults.count > 0)?'hit':'no-hit' });
         	  $analytics.trackSiteSearch(facet, 'AdvancedSearch', $scope.searchResults.count);
       	  }
    	  
      });

      $scope.$on('layerView', function(event) {
        $scope.showMetadata($scope.mdView.current.index,
            $scope.mdView.current.record,
            $scope.mdView.current.records);
      });

      // prevent the floating map from positioning on top of the footer
      $scope.affixFloatingMap = function() {

        $(window).scroll(function (event) {
          var windowTop = $(this).scrollTop() + $(window).height();

          if (windowTop >= $('.footer').offset().top) {
            $('.floating-map-cont').addClass('affix-bottom');
          } else {
            $('.floating-map-cont').removeClass('affix-bottom');
          }
        });
      };

      $scope.$watch('$viewContentLoaded',
	    function() {
	      if (gnViewerSettings.wmsUrl && gnViewerSettings.layerName) {
	        var checkExist = setInterval(function() {
	          if ($('.map').length) {
	            var bodyClass = $('body').attr('class');
	            if (bodyClass.indexOf("full-map-view") == -1) {
	              $scope.showMapPanel();
	              $scope.resizeMapPanel();
	            } else {
	              $scope.mapFullView = true;
	            }
	            clearInterval(checkExist);
	          }
	        }, 100);
	      }
	    });

      $rootScope.$on('$includeContentLoaded', function() {
        $timeout($scope.affixFloatingMap());

        console.log("searchMap refresh");
        $timeout(function() {
          searchMap.updateSize();
          searchMap.renderSync();
        }, 500);

      });

      $scope.toggleMap = function() {
        $(searchMap.getTargetElement()).toggle();
      };

      /**
       * Toogle a favorite metadata selection.
       *
       * @param {number} id  Metadata identifier
         */
      $scope.toggleFavorite = function(id) {
        if ($localStorage.favoriteMetadata == undefined) {
          $localStorage.favoriteMetadata = [];
        }

        var pos = $localStorage.favoriteMetadata.indexOf(id);

        if (pos > -1) {
          $localStorage.favoriteMetadata.splice(pos, 1);
        } else {
          $localStorage.favoriteMetadata.push(id);
        }
      };

      /**
       * Checks if a metadata is in the favorite selection.
       *
       * @param {number} id Metadata identifier
       * @return {boolean}
         */
      $scope.containsFavorite = function(id) {
        if ($localStorage.favoriteMetadata == undefined) {
          $localStorage.favoriteMetadata = [];
        }

        var pos = $localStorage.favoriteMetadata.indexOf(id);

        return (pos > -1);
      };

      hotkeys.bindTo($scope)
          .add({
            combo: 'h',
            description: $translate('hotkeyHome'),
            callback: function(event) {
              $location.path('/home');
            }
          }).add({
            combo: 't',
            description: $translate('hotkeyFocusToSearch'),
            callback: function(event) {
              event.preventDefault();
              var anyField = $('#gn-any-field');
              if (anyField) {
                gnUtilityService.scrollTo();
                $location.path('/search');
                anyField.focus();
              }
            }
          //}).add({
          //  combo: 'enter',
          //  description: $translate('hotkeySearchTheCatalog'),
          //  allowIn: 'INPUT',
          //  callback: function() {
          //    $location.search('tab=search');
          //  }
            //}).add({
            //  combo: 'r',
            //  description: $translate('hotkeyResetSearch'),
            //  allowIn: 'INPUT',
            //  callback: function () {
            //    $scope.resetSearch();
            //  }
          }).add({
            combo: 'm',
            description: $translate('hotkeyMap'),
            callback: function(event) {
              $location.path('/map');
            }
          });


      // TODO: Previous record should be stored on the client side
      $scope.mdView = mdView;
      gnMdView.initMdView();
      $scope.goToSearch = function(any) {
        $location.path('/search').search({'any': any});
      };
      $scope.canEdit = function(record) {
        // TODO: take catalog config for harvested records
        if (record && record['geonet:info'] &&
            record['geonet:info'].edit == 'true') {
          return true;
        }
        return false;
      };
      $scope.openRecord = function(index, md, records) {
        gnMdView.feedMd(index, md, records);
      };

      $scope.closeRecord = function() {
        gnMdView.removeLocationUuid();
      };
      $scope.nextRecord = function() {
        // TODO: When last record of page reached, go to next page...
        $scope.openRecord(mdView.current.index + 1);
      };
      $scope.previousRecord = function() {
        $scope.openRecord(mdView.current.index - 1);
      };


      /**
       * Returns an array of map links for a metadata.
       *
       * @param {object} md
       * @return {Array}
         */
      $scope.getMapLinks = function(md) {
        var links = [];

        if (md == null) return links;

        for (var t in gnSearchSettings.linkTypes.layers) {
          var d = md.getLinksByType(gnSearchSettings.linkTypes.layers[t]);

          if (d.length > 0) {
            links = links.concat(d);
          }
        }

        return links;
      };


      /**
       * Returns an array of download links for a metadata.
       *
       * @param {object} md
       * @return {Array}
       */
      $scope.getDownloadLinks = function(md) {
        var downloads = [];

        if (md == null) return downloads;

        for (var t in gnSearchSettings.linkTypes.downloads) {
          var d = md.getLinksByType(gnSearchSettings.linkTypes.downloads[t]);

          if (d.length > 0) {
            downloads = downloads.concat(d);
          }
        }

        return downloads;
      };

		$scope.printPdf = function(mdView) {
			var uuid = mdView.current.record['geonet:info'].uuid;
			var config = {
				url: '../../GetMetaDataById',
				params: {'id':uuid},
				headers:{'Accept': 'text/html, application/xhtml+xml, */*'},
				method: 'GET'
			};
			$http(config).success(function(htmlString) {
				var frame = document.getElementById('iframe');
				var theFrameDocument = frame.contentDocument || frame.contentWindow.document;
				if(htmlString) {
					htmlString = htmlString.replace('fromInBuiltStyleSheet!==false','fromInBuiltStyleSheet!==true');
				}
				var htmlStr = $sce.trustAsHtml(htmlString);
				theFrameDocument.open();
				theFrameDocument.write(htmlStr);
				theFrameDocument.close();
			})
			.error(function(data) {
				alert('Fel: Kan inte skriv ut.');
			});
		};


      /**
       * Returns an array of information links for a metadata.
       *
       * @param {object} md
       * @return {Array}
       */
      $scope.getInformationLinks = function(md) {
        var information = [];

        if (md == null) return information;

        for (var t in gnSearchSettings.linkTypes.links) {
          var d = md.getLinksByType(gnSearchSettings.linkTypes.links[t]);

          if (d.length > 0) {
            information = information.concat(d);
          }
        }

        return information;
      };

      $scope.infoTabs = {
        lastRecords: {
          title: 'lastRecords',
          titleInfo: '',
          active: true
        },
        preferredRecords: {
          title: 'preferredRecords',
          titleInfo: '',
          active: false
        }};

      // Set the default browse mode for the home page
      $scope.$watch('searchInfo', function() {
        if (angular.isDefined($scope.searchInfo.facet)) {
          if ($scope.searchInfo.facet['inspireThemes'].length > 0) {
            $scope.browse = 'inspire';
          } else if ($scope.searchInfo.facet['topicCats'].length > 0) {
            $scope.browse = 'topics';
            //} else if ($scope.searchInfo.facet['categories'].length > 0) {
            //  $scope.browse = 'cat';
          }
        }
      });


      $scope.resultviewFns = {
        addMdLayerToMap: function(link, md) {

          if (gnMap.isLayerInMap(viewerMap,
              link.name, link.url)) {
            return;
          }
          gnMap.addWmsFromScratch(viewerMap, link.url, link.name, false, md);
        },
        addWmsLayersFromCap: function(url, md) {
          // Open the map panel
          $scope.showMapPanel();
          var name = 'layers';
          var match = RegExp('[?&]' + name + '=([^&]*)').exec(url);
          var layersList = match &&
              decodeURIComponent(match[1].replace(/\+/g, ' '));

          if (layersList) {
            layersList = layersList.split(',');

            for (var i = 0; i < layersList.length; i++)
              if (!gnMap.isLayerInMap(viewerMap,
                  layersList[i], url)) {
                gnMap.addWmsFromScratch(viewerMap, url, layersList[i],
                    false, md);
              }
          } else {
            gnMap.addWmsAllLayersFromCap(viewerMap, url, false,  md);
          }

        },
        addAllMdLayersToMap: function(layers, md) {
          angular.forEach(layers, function(layer) {
            $scope.resultviewFns.addMdLayerToMap(layer, md);
          });
        },
        loadMap: function(map) {
          gnOwsContextService.loadContext(map, viewerMap);
        }
      };

      // Manage route at start and on $location change
      if (!$location.path()) {
        // default to filter dataset and series metadata
        $location.path('/search').search({'type': 'dataset or series'});
      }

      $scope.activeTab = $location.path().
          match(/^(\/[a-zA-Z0-9]*)($|\/.*)/)[1];


      $scope.activateTabs = function() {
        // activate tabs
        $('#tab-result-nav a').click(function (e) {
          e.preventDefault();
          $(this).tab('show');
        });
        // hide empty
        $('#tab-result-nav a').each(function() {
          if ($($(this).attr('href')).length === 0) {
            $(this).parent().hide();
          }
        });
        // show the first
        $('#tab-result-nav a:first').tab('show');
      };


      /**
       * Checks the metadata schema and if not Swedish schema,
       * confirms that the user wants to continue.
       *
       * @param {object} md  Metadata
       */
      $scope.editMetadata = function(md) {
        var schema = md['geonet:info'].schema;

        if (schema == 'iso19139') {
          if (!confirm($translate.instant('nonSweMetadata'))) {
            return;
          }
        }

        $window.open("catalog.edit#/metadata/" + md['geonet:info'].id, '_blank');
      };

      $scope.showMetadata = function(index, md, records) {
        angular.element('.geodata-row-popup').addClass('show');
        $scope.$emit('body:class:add', 'show-overlay');
        gnMdView.feedMd(index, md, records);

        var mdUrl = 'md.format.xml?xsl=xsl-view&view=full-view-swe&uuid={{uuid}}'; // + md['geonet:info'].uuid;
        // set scope md
        $scope.md = md;

        gnMdFormatter.getFormatterUrl(mdUrl, $scope, md['geonet:info'].uuid).then(function(url) {
          $http.get(url).then(
            function(response) {
              var snippet = response.data.replace(
                  '<?xml version="1.0" encoding="UTF-8"?>', '');

              $('#gn-metadata-display').find('*').remove();

              //$scope.compileScope.$destroy();

              // Compile against a new scope
              $scope.compileScope = $scope.$new();
              var content = $compile(snippet)($scope.compileScope);

              $('#gn-metadata-display').append(content);

              $scope.activateTabs();
            });
          });

      };

      /**
       * Displays the metadata BBOX in the search map.
       *
       * @param {object} md  Metadata
         */
      $scope.showMetadataGeometry = function(md) {
        $scope.vectorLayer.getSource().clear();
        $scope.vectorLayerBM.getSource().clear();
        //To toggle or remove the added extent from map
        if (md.defaultTitle == $scope.vectorLayer.get("defaultTitle")){
             $scope.vectorLayer.set("defaultTitle",null);
             $scope.vectorLayerBM.set("defaultTitle",null);
        }
        else{
          var feature = gnMap.getBboxFeatureFromMd(md,
            $scope.searchObj.searchMap.getView().getProjection());
          $scope.vectorLayer.set("defaultTitle",md.defaultTitle);
          $scope.vectorLayerBM.set("defaultTitle",md.defaultTitle);
          $scope.vectorLayer.getSource().addFeature(feature);
          $scope.vectorLayerBM.getSource().addFeature(feature);
        }

      };

	  $scope.fetchInitiativKeyword = function(md) {
		var imgPath = '../../catalog/views/swe/images/noto.png';
		if(md) {
			var initiativKeyword = md.initiativKeyword;
			if(initiativKeyword) {
				var initiativKeywordString = initiativKeyword.toString();
				if(initiativKeywordString.indexOf('ppna data') > -1 ) { // Not using 'Ö' but just using word 'ppna data'. Has some issue with browsers. So keeping it simple.
					imgPath = '../../catalog/views/swe/images/opendata.png';
				} else if(initiativKeywordString.indexOf('Geodatasamverkan') > -1) {
					imgPath = '../../catalog/views/swe/images/geodatacooperation.png';
				}
			}
		}
        return imgPath;
      };

      /**
       * Show full view results.
       */
      $scope.setFullViewResults = function() {
        angular.element('.geo-data-list-cont').removeClass('compact');
        angular.element('.geo-data-row').removeClass('compact-view');
        angular.element('.detail-view').addClass('active');
        angular.element('.compact-view').removeClass('active');
        $scope.viewMode = 'full';
      };

      /**
       * Show compact view results.
       */
      $scope.setCompactViewResults = function() {
        angular.element('.geo-data-list-cont').addClass('compact');
        angular.element('.geo-data-row').addClass('compact-view');
        angular.element('.compact-view').addClass('active');
        angular.element('.detail-view').removeClass('active');
        $scope.viewMode = 'compact';
      };

       //For collapsible
      $scope.image_filter_height = $('.site-image-filter').height();
      $scope.actual_height = $scope.image_filter_height;
        $scope.$watch('image_filter_height', function (newValue, oldValue, scope) {
        $scope.actual_height = oldValue;
        exampleResize.onResize($rootScope, $scope);

      });

      /**
       * Show map panel.
       */
      $scope.showMapPanel = function() {
        angular.element('.floating-map-cont').hide();
        $scope.$emit('body:class:add', 'small-map-view');
        $scope.actual_height = $('.site-image-filter').height();
        exampleResize.onResize($rootScope, $scope);
        scope = shareGnMainViewerScope.sharedScope;
         $timeout(function() {
          viewerMap.updateSize();
          viewerMap.renderSync();
          gnMap.hideOrShowMapTool(scope);
        }, 500);
      };

      $scope.resizeCheck = function(){
        $scope.image_filter_height = $('.site-image-filter').height();
        $scope.collapsed =! $scope.collapsed;
        scope = shareGnMainViewerScope.sharedScope;
         $timeout(function() {
            gnMap.hideOrShowMapTool(scope);
          }, 500);

      };

      /**
       * Show full map panel.
       */
      $scope.showFullMapPanel = function() {
        angular.element('.floating-map-cont').hide();
        $scope.$emit('body:class:remove', 'large-map-view');
        $scope.$emit('body:class:remove', 'medium-map-view');
        $scope.$emit('body:class:remove', 'small-map-view');
        $scope.$emit('body:class:add', 'full-map-view');
        $scope.$emit('body:class:add', 'scroll-blocked');
    	$scope.mapFullView = true;
        is_map_maximized.data = true;
        window_width = angular.element($window).width();
		$map_data_list_cont = angular.element('.map-data-list-cont');
        is_side_data_bar_open = ($map_data_list_cont.hasClass('open')) ? true : false;
        $data_list_cont = angular.element('.data-list-cont');
        $map_cont = angular.element('.map-cont');
        $obj = angular.element('#map-panel-resize');
		$objMax = angular.element('#map-panel-resize-max');
		$objMedium = angular.element('#map-panel-resize-medium');

        if (is_side_data_bar_open) {
          $map_cont.css({
            width: (window_width - $data_list_cont.width())
          });
        } else {
          $map_cont.css({
            width: window_width
          });
        }

        $obj.removeClass('full').addClass('small');
		$obj.addClass('ng-hide');
		$objMax.removeClass('ng-hide');
		$objMedium.addClass('ng-hide');

		$scope.actual_height = $('.site-image-filter').height();
	    exampleResize.onResize($rootScope, $scope);
        $timeout(function() {
         viewerMap.updateSize();
         viewerMap.renderSync();
       }, 500);
      };

      /**
       * Show full map panel from url.
       */
      $scope.showFullMapPanelApi = function() {
        angular.element('.floating-map-cont').hide();
        $scope.$emit('body:class:remove', 'large-map-view');
        $scope.$emit('body:class:remove', 'medium-map-view');
        $scope.$emit('body:class:remove', 'small-map-view');
        $scope.$emit('body:class:add', 'full-map-view');
        $scope.$emit('body:class:add', 'scroll-blocked');
	    $scope.mapFullView = true;
        is_map_maximized.data = true;
        window_width = angular.element($window).width();
		$map_data_list_cont = angular.element('.map-data-list-cont');
        is_side_data_bar_open = ($map_data_list_cont.hasClass('open')) ? true : false;
        $data_list_cont = angular.element('.data-list-cont');
        $map_cont = angular.element('.map-cont');
        $obj = angular.element('#map-panel-resize');

        if (is_side_data_bar_open) {
          $map_cont.css({
            width: (window_width - $data_list_cont.width())
          });
        } else {
          $map_cont.css({
            width: window_width
          });
        }

        $obj.removeClass('full').addClass('small');
		$scope.actual_height = 240;
	    exampleResize.onResize($rootScope, $scope);
        $timeout(function() {
         viewerMap.updateSize();
         viewerMap.renderSync();
       }, 500);
      };

      var debounce = function(func,wait) {
        var timeout;
        return function() {
            var context = this,
                args = arguments;
            var later = function() {
                timeout = null;
                func.apply(context,args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
      };

      /**
       * Resize the full map
       *
       * Only do a resize when the full map is shown
       */
      var resizeFullMap = function() {

        if (is_map_maximized.data) {

          is_side_data_bar_open = ($map_data_list_cont.hasClass('open')) ? true : false;
          window_width = angular.element($window).width();
          $map_cont = angular.element('.map-cont');
          $data_list_cont = angular.element('.data-list-cont');

          // update the size of the map container
          if (is_side_data_bar_open) {
            $map_cont.css({
              width: (window_width - $data_list_cont.width())
            });
          } else {
            $map_cont.css({
              width: window_width
            });
          }

          // refresh the size of the map itself
          $timeout(function() {
            viewerMap.updateSize();
            viewerMap.renderSync();
          }, 500);
        }
      };

      /**
       * Refresh map panel after a window resize
       *
       * a debounce function is used in order to resize only once after the resizing has stopped,
       * and not continually resizing the map during resizing the window
       */
      angular.element($window).bind('resize', debounce(function (){

        resizeFullMap();

      },200));

      /**
       * Hide map panel.
       */
      $scope.hideMapPanel = function() {
		$predefMap = angular.element('.selected-img');
		$predefMap.removeClass('selected-img').addClass('bg-img');
        angular.element('.floating-map-cont').show();
        $scope.$emit('body:class:remove', 'small-map-view');
        $scope.$emit('body:class:remove', 'full-map-view');
        $scope.$emit('body:class:remove', 'medium-map-view');
        $scope.$emit('body:class:remove', 'large-map-view');
        $timeout(function() {
          searchMap.updateSize();
          searchMap.renderSync();
        }, 500);
      };

      $scope.resizeMapPanel = function() {
        $predefMap = angular.element('.selected-img');
		$predefMap.removeClass('selected-img').addClass('bg-img');
        angular.element('#imageFilter').scope().is_image_clicked = false;
        $timeout(function() {
              angular.element('.bg-img').css("opacity", "1");
              angular.element('.selected-img').css("opacity", "1");
        }, 250);
        $scope.mapFullView =! $scope.mapFullView;
        var $b = angular.element(document).find('body');
        window_width = angular.element($window).width(),
        $map_data_list_cont = angular.element('.map-data-list-cont'),
        is_side_data_bar_open = ($map_data_list_cont.hasClass('open')) ? true : false,
        is_full_view_map = ($b.hasClass('full-map-view')) ? true : false,
        is_large_view_map = ($b.hasClass('large-map-view')) ? true : false,
        $data_list_cont = angular.element('.data-list-cont'),
        $map_cont = angular.element('.map-cont'),
        $obj = angular.element('#map-panel-resize');
		$objMax = angular.element('#map-panel-resize-max');
		$objMedium = angular.element('#map-panel-resize-medium');
        //To restrict GFI only when map are maximized
        is_map_maximized.data = !is_full_view_map;
        if (is_full_view_map) {

          $scope.mapFullView = false;

          if (is_side_data_bar_open) {
            $scope.$emit('body:class:remove', 'full-map-view');
            $scope.$emit('body:class:add', 'medium-map-view');
          }
          else {
            $scope.$emit('body:class:remove', 'full-map-view');
            $scope.$emit('body:class:add', 'small-map-view');
          }
          $obj.removeClass('small').addClass('full');
          $scope.$emit('body:class:remove', 'scroll-blocked');
    	  $obj.removeClass('ng-hide');
		  $objMax.addClass('ng-hide');
		  $objMedium.removeClass('ng-hide');
        }
        else if (is_large_view_map) {
          if (is_side_data_bar_open) {
            $scope.$emit('body:class:remove', 'large-map-view');
            $scope.$emit('body:class:add', 'medium-map-view');
          } else {
            $scope.$emit('body:class:remove', 'large-map-view');
            $scope.$emit('body:class:add', 'small-map-view');
          }
          $obj.removeClass('small').addClass('full');
          $scope.$emit('body:class:remove', 'scroll-blocked');
    	}
        else {
          $scope.$emit('body:class:remove', 'large-map-view');
          $scope.$emit('body:class:remove', 'medium-map-view');
          $scope.$emit('body:class:remove', 'small-map-view');
          $scope.$emit('body:class:add', 'full-map-view');

          if (is_side_data_bar_open) {
            $map_cont.css({
              width: (window_width - $data_list_cont.width())
            });
            }
          else {
            $map_cont.css({
              width: window_width
              });
          }
         $obj.removeClass('full').addClass('small');
         $scope.$emit('body:class:add', 'scroll-blocked');
        }

        // Refresh the viewer map

		$scope.actual_height = $('.site-image-filter').height();
        exampleResize.onResize($rootScope, $scope);

        $timeout(function() {
          viewerMap.updateSize();
          viewerMap.renderSync();

          $("div.bootstrap-table div.fixed-table-container div.fixed-table-body table").each(function( ) {
            $( this ).bootstrapTable('resetView');
          });

        }, 500);

        return false;
      };


      $scope.$on('$locationChangeSuccess', function(next, current) {
        var path = $location.path().match(/^(\/[a-zA-Z0-9]*)($|\/.*)/);
        if (path){
    	$scope.activeTab = $location.path().
            match(/^(\/[a-zA-Z0-9]*)($|\/.*)/)[1];
        }
        if (gnSearchLocation.isSearch() && (!angular.isArray(
            searchMap.getSize()) || searchMap.getSize()[0] < 0)) {

          $timeout(function() {
            searchMap.updateSize();
            searchMap.renderSync(1000);

            // TODO: load custom context to the search map
            //gnOwsContextService.loadContextFromUrl(
            //  gnViewerSettings.defaultContext,
            //  searchMap);

          }, 0);
        }
        if (gnSearchLocation.isMap() && (!angular.isArray(
            viewerMap.getSize()) || viewerMap.getSize().indexOf(0) >= 0)) {
          setTimeout(function() {
            viewerMap.updateSize();
          }, 0);
        }
      });

      angular.extend($scope.searchObj, {
        advancedMode: false,
        from: 1,
        to: 30,
        viewerMap: viewerMap,
        searchMap: searchMap,
        mapfieldOption: {
          relations: ['within']
        },
        defaultParams: {
          'facet.q': '',
          resultType: gnSearchSettings.facetsSummaryType || 'details',
          _schema: 'iso19139*'
        },
        params: {
          'facet.q': '',
          resultType: gnSearchSettings.facetsSummaryType || 'details',
          _schema: 'iso19139*'
        }
      }, gnSearchSettings.sortbyDefault);

      // Refreshes the map in the initial load, otherwise no map displayed
      // until the window is resize or the user clicks the map.
      // Tried other options, but not working.
      searchMap.once('postrender', function(){
        searchMap.updateSize();
        searchMap.renderSync();
      });

      //If postrender fails to refresh map.It will refresh the map in specific time interval
      $timeout(function() {
        searchMap.updateSize();
        searchMap.renderSync();
      }, 2000);

      // The url contains the path to display a metadata.
      // Trigger a search  to get the metadata and handle
      // in the search events the display of the metadata.
      if ($location.path().indexOf("/metadata/") == 0) {
        $scope.displayInitialMetadata = true;
        $scope.displayInitialMetadataUUID = $location.path().substring($location.path().lastIndexOf("/")+1);
        $scope.searchObj.params.or = $scope.displayInitialMetadataUUID;
        $scope.triggerSearch();
      }
      }]);

  module.controller('SweLogoutController',
	  ['$scope', '$http',
	  function($scope, $http) {

		  $scope.logout = function() {
			  $http({method: 'GET',
	              url: '/AGLogout'

	              /*headers: {
	                'X-Ajax-call': true}*/})
	            .success(function(data) {
	             // Redirect to home page
	             window.location.href = 'catalog.search';
	           })
	            .error(function(data) {
	             // Show error message
	             alert('Error');
	           });
		  };
	  }]);

  /**
   * Controller for mail feedback popup.
   *
   */
  module.controller('SweMailController', [
    '$cookies', '$scope', '$http',
    function($cookies, $scope, $http) {
      $scope.feedbackResult = null;
      $scope.feedbackResultError = false;

      $scope.sendMail = function() {
        if ($scope.feedbackForm.$invalid) return;

        $http.post('../api/0.1/site/feedback-swe', null, {params: $scope.user})
            .then(function successCallback(response) {
              $scope.feedbackResult = response.data;
              $scope.feedbackResultError = false;

            }, function errorCallback(response) {
              $scope.feedbackResult = response.data;
              $scope.feedbackResultError = true;

            });
      };

      $scope.close = function() {
        // Cleanup and close the dialog
        $scope.user = {};
        $scope.feedbackResult = null;
        $scope.feedbackResultError = false;

        $scope.feedbackForm.$setPristine();
        $scope.feedbackForm.$setValidity();

        angular.element('#mail-popup').removeClass('show');
        $scope.$emit('body:class:remove', 'show-overlay');
      };
    }]);

  /**
   * Controller for help popup.
   *
   */
  module.controller('SweHelpController', [
    '$cookies', '$scope', '$http', '$rootScope', '$sce',
    function($cookies, $scope, $http, $rootScope, $sce) {

	  $rootScope.$on('openhelppopup', function (event, data) {
		  $scope.link = data;
		  });
	  $scope.trustSrc = function(link) {
		   return $sce.trustAsResourceUrl(link);
		};
      $scope.close = function() {
        // Cleanup and close the dialog
        angular.element('#help-popup').removeClass('show');
      };
    }]);



  /**
   * Controller for new metadata popup.
   *
   */
  module.controller('SweNewMetadataController', [
    '$cookies', '$scope', '$rootScope', '$http', '$window', 'gnSearchManagerService', 'gnMetadataManager',
    function($cookies, $scope, $rootScope, $http, $window, gnSearchManagerService, gnMetadataManager) {
      var dataTypesToExclude = ['staticMap', 'theme', 'place'];
      var defaultType = 'dataset';
      var unknownType = 'unknownType';
      var fullPrivileges = true;

      var init = function() {

        // Metadata creation could be on a template
        // or by duplicating an existing record
        var query = 'template=y';

          // TODO: Better handling of lots of templates
          gnSearchManagerService.search('qi@json?template=y' +
            '&fast=index&from=1&to=200&_schema=iso19139.swe').
          then(function(data) {

            $scope.mdList = data;
            $scope.hasTemplates = data.count != '0';

            var types = [];
            // TODO: A faster option, could be to rely on facet type
            // But it may not be available
            for (var i = 0; i < data.metadata.length; i++) {
              var type = data.metadata[i].type || unknownType;
              if (type instanceof Array) {
                for (var j = 0; j < type.length; j++) {
                  if ($.inArray(type[j], dataTypesToExclude) === -1 &&
                    $.inArray(type[j], types) === -1) {
                    types.push(type[j]);
                  }
                }
              } else if ($.inArray(type, dataTypesToExclude) === -1 &&
                $.inArray(type, types) === -1) {
                types.push(type);
              }
            }
            types.sort();
            $scope.mdTypes = types;

            // Select the default one or the first one
            if (defaultType &&
              $.inArray(defaultType, $scope.mdTypes) > -1) {
              $scope.getTemplateNamesByType(defaultType);
            } else if ($scope.mdTypes[0]) {
              $scope.getTemplateNamesByType($scope.mdTypes[0]);
            } else {
              // No templates available ?
            }
          });

      };

      /**
       * Get all the templates for a given type.
       * Will put this list into $scope.tpls variable.
       */
      $scope.getTemplateNamesByType = function(type) {
        var tpls = [];
        $scope.titleFilter = '';
        for (var i = 0; i < $scope.mdList.metadata.length; i++) {
          var mdType = $scope.mdList.metadata[i].type || unknownType;
          if (mdType instanceof Array) {
            tpls.push($scope.mdList.metadata[i]);

            //if (mdType.indexOf(type) >= 0) {
            //  tpls.push($scope.mdList.metadata[i]);
            //}
          } else if (mdType == type) {
            tpls.push($scope.mdList.metadata[i]);
          } else {
            tpls.push($scope.mdList.metadata[i]);
          }
        }

        // Sort template list
        function compare(a, b) {
          if (a.title < b.title)
            return -1;
          if (a.title > b.title)
            return 1;
          return 0;
        }
        tpls.sort(compare);

        $scope.tpls = tpls;
        $scope.activeType = type;
        $scope.setActiveTpl($scope.tpls[0]);
        return false;
      };

      $scope.setActiveTpl = function(tpl) {
        $scope.activeTpl = tpl;
      };

      $scope.createNewMetadata = function(isPublic) {
        var metadataUuid = '';

        var editorAppUrl = $window.location.origin +
            $window.location.pathname.replace('catalog.search', 'catalog.edit') + '#';

        return gnMetadataManager.create(
          $scope.activeTpl['geonet:info'].id,
          $scope.ownerGroup,
          isPublic || false,
          false,
          false,
          undefined,
          metadataUuid,
          editorAppUrl
        ).error(function(data) {
          $rootScope.$broadcast('StatusUpdated', {
            title: $translate('createMetadataError'),
            error: data.error,
            timeout: 0,
            type: 'danger'});
        });
      };

      $scope.close = function() {
        // Cleanup and close the dialog

        angular.element('#newmetadata-popup').removeClass('show');
        $scope.$emit('body:class:remove', 'show-overlay');
      };

      init();
    }]);


  /**
   * Controller for the filter panel.
   *
   */
  module.controller('SweFilterPanelController', ['$scope', '$filter', '$localStorage',
    function($scope, $filter, $localStorage) {

      $scope.advancedMode = false;

      // keys for topic categories translations
      $scope.topicCategories = ['farming', 'biota', 'boundaries',
        'climatologyMeteorologyAtmosphere', 'economy',
        'elevation', 'environment', 'geoscientificInformation', 'health',
        'imageryBaseMapsEarthCover', 'intelligenceMilitary', 'inlandWaters',
        'location', 'oceans', 'planningCadastre', 'society', 'structure',
        'transportation', 'utilitiesCommunication'];

      // Selected topic categories
      $scope.selectedTopicCategories = [];

      $scope.selectedExclusiveFilter = 'type';

      // Map with search criteria and search param related
      $scope.exclusiveFilterSeachParams = {
        'type': 'type',
        'map': 'dynamic',
        'download': 'download',
        'favorites': '_id'
      };

      /**
       * Toggles between exclusive filters.
       *
       * @param {String} param name used in the filter
       * @param {array} types
       */
      $scope.toggleExclusiveFilter = function(type, values) {
        // Exclusive filters act as radio buttons,
        // but can be disabled all
        if ($scope.selectedExclusiveFilter == type) {
          var paramName = $scope.exclusiveFilterSeachParams[type];
          $scope.searchObj.params[paramName] = '';
          $scope.selectedExclusiveFilter = '';
          $scope.triggerSearch();

          return;
        }

        $scope.selectedExclusiveFilter = type;

        // Clear the exclusive search filters
        Object.keys($scope.exclusiveFilterSeachParams).forEach(function(key) {
            var paramName = $scope.exclusiveFilterSeachParams[key];
            $scope.searchObj.params[paramName] = "";
        });

        if (type == 'favorites') {
          // Use an invalid value -- to manage the case no favorites are selected,
          // to don't display any metadata
          if ($localStorage.favoriteMetadata != undefined) {
            $scope.searchObj.params._id =
                ($scope.searchObj.params._id ? '' :
                    ($localStorage.favoriteMetadata.length > 0) ?
                        $localStorage.favoriteMetadata.join(' or ') : '--');
          } else {
            $scope.searchObj.params._id =
                ($scope.searchObj.params._id ? '' : '--');
          }
        } else {
          var paramName = $scope.exclusiveFilterSeachParams[type];
          $scope.searchObj.params[paramName] =
              (values instanceof Array)?values.join(' or '):values;
        }

        $scope.triggerSearch();
      };


      /**
       * Toggles a topic category selection.
       *
       * @param {string} topic
         */
      $scope.toggleTopicCategory = function(topic) {
        var pos = $scope.selectedTopicCategories.indexOf(topic);

        if (pos > -1) {
          $scope.selectedTopicCategories.splice(pos, 1);
        } else {
          $scope.selectedTopicCategories.push(topic);
        }

        $scope.searchObj.params.topicCat =
            $scope.selectedTopicCategories.join(' or ');
        $scope.triggerSearch();
      };


      /**
       * Unselects a topic category.
       *
       * @param {string} topic
         */
      $scope.unselectTopicCategory = function(topic) {
        var pos = $scope.selectedTopicCategories.indexOf(topic);

        if (pos > -1) {
          $scope.selectedTopicCategories.splice(pos, 1);
        }

        $scope.searchObj.params.topicCat =
            $scope.selectedTopicCategories.join(' or ');
        $scope.triggerSearch();
      };


      /**
       * Checks if a topic category is selected.
       *
       * @param {string} topic
       * @return {boolean}
         */
      $scope.isTopicCategorySelected = function(topic) {
        return ($scope.selectedTopicCategories.indexOf(topic) > -1);
      };


      /**
       * Unselects the resource date from.
       */
      $scope.unselectResourceDateFrom = function() {
        delete $scope.searchObj.params.resourceDateFrom;
        $scope.triggerSearch();
      };


      /**
       * Unselects the resource date to.
       */
      $scope.unselectResourceDateTo = function() {
        delete $scope.searchObj.params.resourceDateTo;
        $scope.triggerSearch();
      };


      /**
       * Unselects the geometry filter.
       */
      $scope.unselectGeoResources = function() {
        $scope.vectorLayer.getSource().clear();
        $scope.vectorLayerBM.getSource().clear();

        delete $scope.searchObj.params.geometry;
        delete $scope.searchObj.namesearch;
        $scope.triggerSearch();
      };

      $scope.translatedTopicCat = function(p) {
        return $filter('translate')(p);
      }

      /**
       * Clean search options to view all metadata.
       */
      $scope.viewAllMetadata = function() {

        $scope.selectedTopicCategories = [];
        $scope.selectedExclusiveFilter = 'type';
        $scope.searchObj.params.type =
            ['dataset', 'series'].join(' or ');

        delete $scope.searchObj.params.topicCat;
        delete $scope.searchObj.params.download;
        delete $scope.searchObj.params.dynamic;
        delete $scope.searchObj.params.any;
        delete $scope.searchObj.params._id;
        delete $scope.searchObj.params.resourceDateFrom;
        delete $scope.searchObj.params.resourceDateTo;
        delete $scope.searchObj.params.geometry;
        delete $scope.searchObj.namesearch;
        delete $scope.searchObj.params['facet.q'];
		delete $scope.searchObj.params.or;
        $scope.vectorLayer.getSource().clear();
        $scope.vectorLayerBM.getSource().clear();
        $scope.vectorLayer.unset("defaultTitle");
        $scope.vectorLayerBM.unset("defaultTitle");
        $scope.triggerSearch();
      };


      /**
       * Toggles the filter panel.
       */
      $scope.toggleFilterPanel = function() {
        var element = angular.element('.site-filter-cont');
        var filterSection = angular.element('.site-filter-result-cont');

        if (element.hasClass('open')) {
          element.removeClass('open');
          filterSection.removeClass('filter-is-open');
        } else {
          element.addClass('open');
          filterSection.addClass('filter-is-open');
        }
      };

      /**
       * Toggles the advance options panel.
       */
      $scope.toggleAdvancedOptions = function() {
        if ($scope.advancedMode) {
          angular.element('.filter-options-cont').removeClass('open');
          angular.element('.site-filter-cont').removeClass('advanced');
        } else {
          angular.element('.filter-options-cont').addClass('open');
          angular.element('.site-filter-cont').addClass('advanced');
        }

        $scope.advancedMode = !$scope.advancedMode;

        // clear filters
        $scope.viewAllMetadata();
      };

      /**
       * Closes the filter panel.
       */
      $scope.closeFilterPanel = function() {
        angular.element('.site-filter-cont').removeClass('open');
        angular.element('.site-filter-result-cont').removeClass('filter-is-open');

        $scope.open = false;
      };
    }]);

  /**
   * Controller for geo suggestions.
   *
   */
  module.controller('SweGeoSuggestionsController', ['$scope', '$http',
    function($scope, $http) {
    $scope.getNameSearch = function(val) {
//      var posturl = 'https://www.geodata.se/NameWebService/search';
//	  val = encodeURIComponent(val);
//      var params = {
//        'searchstring': val,
//        'callback': 'JSON_CALLBACK'
//      };
//      return $http({
//        method: 'JSONP',
//        url: posturl,
//        params: params
//      }).then(function(res) {
//        var data = res.data;
//        var status = res.status;
//        var headers = res.headers;
//        var config = res.config;
//        var statusText = res.statusText;
//
//
//        return data;
//      });
//    };

    var parent = $scope.$parent;
    var lang = parent.langs[parent.lang];

    var formatter = function(loc) {
        var props = [];
        ['toponymName', 'adminName1', 'countryName'].
            forEach(function(p) {
              if (loc[p]) { props.push(loc[p]); }
            });
        return (props.length == 0) ? '' : '—' + props.join(', ');
      };

    //TODO: move api url and username to config
    var url = 'http://api.geonames.org/searchJSON?';
	  //redirect http request via proxy
 	  if (!url.includes("https://")) {
		url = '../../proxy?url=' + encodeURIComponent(url);
      }  
      return $http.get(url, {
        params: {
          lang: lang,
          style: 'full',
          type: 'json',
          maxRows: 10,
          name_startsWith: val,
          country: 'SE',
          east: 24.1633,
          west: 10.9614,
          north: 69.059,
          south: 55.3363,
          username: 'georchestra'
        }
      }).
        then(function(response) {
          var loc;
          var results = [];
          for (var i = 0; i < response.data.geonames.length; i++) {
            loc = response.data.geonames[i];
            if (loc.bbox) {
              results.push({
                Name: loc.name,
                Type: loc.toponymName,
                extent: ol.proj.transformExtent([loc.bbox.west,
                  loc.bbox.south, loc.bbox.east, loc.bbox.north],
                'EPSG:4326', 'EPSG:3006')
              });
            }
          }
          return results;
        });
  };
  
  }]);

 /**
   * Controller for draw polygon using wfs getfeature.
   *
   */
  module.controller('SweGeoWfsGetFeatureController', ['$scope', '$http', 'gnSearchSettings', 'gnMap', 'gnConfig',
    function($scope, $http, gnSearchSettings, gnMap, gnConfig) {
     /**
       * Displays the polygon in map.
       *
       */
      $scope.drawPolygonInMap = function() {
        //var namesearch = $scope.searchObj.params.namesearch;
        var namesearch = $scope.searchObj.namesearch;
        var extent = namesearch.extent;
        var coordinates = namesearch.Coordinates;
        var geoJson = new ol.format.GeoJSON();
//        if (coordinates) {
        if (extent) {
//          var proj = $scope.searchObj.searchMap.getView().getProjection();

//          var xy0 = coordinates[0];
//          var xy1 = coordinates[1];
//          var extent = []; // geoBox=10.59|55.15|24.18|69.05
//          extent.push(parseFloat(xy0.X), parseFloat(xy0.Y),
//            parseFloat(xy1.X), parseFloat(xy1.Y));
          //To transform projection for metadata list based on polygon drawn
//          proj4.defs("EPSG:3006","+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
          //proj4.defs("EPSG:4258","+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs");
//          var geom = gnMap.reprojExtent(extent , 'EPSG:3006', 'EPSG:4326');
//          var geom_wkt = "POLYGON((" + geom[0] + " " + geom[1] + "," + geom[2] + " " + geom[1] + "," + geom[2] + " " + geom[3] + "," + geom[2] + " " + geom[1] + "," + geom[0] + " " + geom[1] + "))";

          var geom_wkt = "POLYGON((" + extent[0] + " " + extent[1] + "," + extent[2] + " " + extent[1] + "," + extent[2] + " " + extent[3] + "," + extent[2] + " " + extent[1] + "," + extent[0] + " " + extent[1] + "))";
          
          $scope.searchObj.params.geometry = geom_wkt;
          var feature = new ol.Feature();
          //var feature = gnMap.getPolygonFeature(namesearch, $scope.searchObj.searchMap.getView().getProjection());

          // Build multipolygon from the set of bboxes
          geometry = new ol.geom.MultiPolygon(null);
          feature.setGeometry(geometry);

          //$scope.searchObj.searchMap.addLayer($scope.vectorLayer);
           var wfsurl = gnConfig['map.wfsServer.url'];
           var CQL_FILTER = "Name='" + encodeURIComponent(namesearch.Name) + "'";
            var params = {
              'request': 'GetFeature',
              'service': 'WFS',
              'srs': 'EPSG:3006',
              'version': '1.0.0',
              'typeName': gnConfig['map.wfsServer.workspace'] + ":" + gnConfig['map.wfsServer.layer'],
              'outputFormat': 'json',
              'callback': 'JSON_CALLBACK',
              'CQL_FILTER': CQL_FILTER
            };
            return $http({
              method: 'POST',
              url: wfsurl,
              params: params
            }).then(function(result) {
              $scope.vectorLayer.getSource().clear();
              //$scope.searchObj.viewerMap.getLayers().getArray()[1].getSource().clear()
              $scope.vectorLayer.getSource().addFeatures(geoJson.readFeatures(result.data));
              $scope.searchObj.searchMap.getView().setCenter([extent[0],extent[1]]);
              $scope.vectorLayerBM.getSource().clear();
              $scope.vectorLayerBM.getSource().addFeatures(geoJson.readFeatures(result.data));
              $scope.searchObj.searchMap.getView().fit(extent, $scope.searchObj.searchMap.getSize());
              $scope.searchObj.viewerMap.getView().fit(extent, $scope.searchObj.viewerMap.getSize());
              $scope.triggerSearch();
            });

          return true; // always return true so search query is fired.

        } else {
          return false; // always return false if cooridinates are absent. Not sure if we shall still return true.
        }
    };


  }]);

  module.controller('SweGeoFreeHandPolygonController', ['$scope', '$http', '$timeout', 'gnSearchSettings', 'gnMap',
    function($scope, $http, $timeout, gnSearchSettings, gnMap) {
      $scope.drawFreeHandPolygonInMap = function(){

        $scope.showMapPanel();

        var features = new ol.Collection();
        draw = new ol.interaction.Draw({
          features: features,
          type: 'Polygon'
        });

        $scope.searchObj.viewerMap.addInteraction(draw);

        draw.on('drawstart', function (e) {
          $scope.vectorLayer.getSource().clear();
          $scope.vectorLayerBM.getSource().clear();
        });

        draw.on('drawend', function (e) {
          var polygonFeature = e.feature;

          delete $scope.searchObj.namesearch;

          $scope.vectorLayer.getSource().clear();
          $scope.vectorLayer.getSource().addFeature(polygonFeature.clone());

          $scope.vectorLayerBM.getSource().clear();
          $scope.vectorLayerBM.getSource().addFeature(polygonFeature.clone());

          proj4.defs("EPSG:3006","+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");

          var geom = polygonFeature.getGeometry().clone().transform('EPSG:3006', 'EPSG:4326');
          var format = new ol.format.WKT();
          var geom_wkt =format.writeGeometry(geom);

          $scope.hideMapPanel();

          $scope.searchObj.params.geometry = geom_wkt;
          $scope.triggerSearch();

          $timeout(function() {
            $scope.searchObj.viewerMap.removeInteraction(draw);
          }, 500);

        });
      }

    }]);

  /**
   * orderByTranslated Filter
   * Sort ng-options or ng-repeat by translated values
   * @example
   *   ng-repeat="scheme in data.schemes |
   *    orderByTranslated:'storage__':'collectionName'"
   * @param  {Array|Object} array or hash
   * @param  {String} i18nKeyPrefix
   * @param  {String} objKey (needed if hash)
   * @return {Array}
   */
  module.filter('orderByTranslated', ['$translate', '$filter',
    function($translate, $filter) {
      return function(array, i18nKeyPrefix, objKey) {
        var result = [];
        var translated = [];
        angular.forEach(array, function(value) {
          var i18nKeySuffix = objKey ? value[objKey] : value;
          translated.push({
            key: value,
            label: $translate.instant(i18nKeyPrefix + i18nKeySuffix)
          });
        });
        angular.forEach($filter('orderBy')(translated, 'label'),
            function(sortedObject) {
              result.push(sortedObject.key);
            }
        );
        return result;
      };
    }]);

  //To restrict GFI only when map are maximized
  module.factory("is_map_maximized", function() {
    return {data: false};
});

  //
    module.factory('exampleResize', function(){
    return{
      onResize: function($rootScope, $scope){
        cookieCheck = $rootScope.showCookieWarning;
        var $b = angular.element(document).find('body');
        is_full_view_map = ($b.hasClass('full-map-view')) ? true : false;
        is_small_view_map = ($b.hasClass('small-map-view')) ? true : false;
        if(is_small_view_map || is_full_view_map){
              $scope.$emit('body:class:remove', 'geodata-examples-collapsed-with-cookie-alert');
              $scope.$emit('body:class:remove', 'geodata-examples-expanded-with-cookie-alert');
              $scope.$emit('body:class:remove', 'geodata-examples-expanded-larger-with-cookie-alert');
              $scope.$emit('body:class:remove', 'geodata-examples-collapsed-without-cookie-alert');
              $scope.$emit('body:class:remove', 'geodata-examples-expanded-without-cookie-alert');
              $scope.$emit('body:class:remove', 'geodata-examples-expanded-larger-without-cookie-alert');
          if(cookieCheck){
             if($scope.collapsed){
              $scope.$emit('body:class:add', 'geodata-examples-collapsed-with-cookie-alert');
          }
              else{
                 if($scope.actual_height < 60){
                  $scope.$emit('body:class:add', 'geodata-examples-collapsed-with-cookie-alert');
                }
                else if($scope.actual_height < 250){
                  $scope.$emit('body:class:add', 'geodata-examples-expanded-with-cookie-alert');
                }
                else{
                  $scope.$emit('body:class:add', 'geodata-examples-expanded-larger-with-cookie-alert');
                }
            }
          }
          else{
              if($scope.collapsed){
                $scope.$emit('body:class:add', 'geodata-examples-collapsed-without-cookie-alert');
            }
              else{
                if($scope.actual_height < 60){
                  $scope.$emit('body:class:add', 'geodata-examples-collapsed-without-cookie-alert');
                }
                else if($scope.actual_height < 250){
                  $scope.$emit('body:class:add', 'geodata-examples-expanded-without-cookie-alert');
                }
                else{
                  $scope.$emit('body:class:add', 'geodata-examples-expanded-larger-without-cookie-alert');
                }
              }
          }
        }

      }
    }

  });

})();
