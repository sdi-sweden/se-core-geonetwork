'use strict';

//http://chaijs.com/
var chai = require('chai');
//var expect = require('expect')
//var jasmine = require('jasmine')
//https://github.com/domenic/chai-as-promised/
var chaiAsPromised = require('chai-as-promised');
chai.use(chaiAsPromised);
var expect = chai.expect;
var assert = chai.assert;
//chai.should();
var EC = protractor.ExpectedConditions;

//var expect = chai.expect;
var ResultList = require('../pages/ResultList.js');
list = new ResultList();

var SearchFilter = require('../pages/filter.js');
searchfilter = new SearchFilter();

module.exports = function () {
	var allaMD = 85

	this.Given(/^that the user has selected some fiters$/, function (callback) {
		browser.driver.sleep(3000);
		var el = element(by.css('span.result-text'));
		allaMD = el.$('.ng-binding').getText();
		searchfilter.selectCategory("EKONOMI");
		callback();
	});

	this.When(/^the user clicks the button to visa alla resurser$/, function (callback) {
		searchfilter.clearFilter;
		callback();
	});

	this.Then(/^all filters are removed$/, function (callback) {
		searchfilter.getSelectedFilterList.then(function (items) {
			chai.assert.lengthOf(items, 7);
		});
		expect(element(by.css('[data-ng-show="searchObj.params.resourceDateFrom"]')).getAttribute('class')).to.eventually.equal('ng-hide');
		expect(element(by.css('[data-ng-show="searchObj.params.resourceDateTo != undefined"]')).getAttribute('class')).to.eventually.equal('ng-hide');
		expect(element(by.css('[data-ng-show="searchObj.params.dynamic == \'true\'"]')).getAttribute('class')).to.eventually.equal('ng-hide');
		expect(element(by.css('[data-ng-show="searchObj.params.download == \'true\'"]')).getAttribute('class')).to.eventually.equal('ng-hide').and.notify(callback);
		expect(element(by.css('[data-ng-show="(searchObj.params._id != \'\') && (searchObj.params._id != undefined)"]')).getAttribute('class')).to.eventually.equal('ng-hide').and.notify(callback);

		callback();
	});

	this.Then(/^all posts are shown$/, function (callback) {
		browser.driver.sleep(3000);
		allaMD.then(function (a) {
			var els = element(by.css('span.result-text'));
			expect(els.$('.ng-binding').getText()).to.eventually.equal(a).and.notify(callback);
		});
		callback();
	});

	this.Given(/^that the result list contains metadata poster$/, function (callback) {
		browser.driver.manage().window().maximize();
		browser.driver.sleep(3000);
		var el = element(by.css('span.result-text'));
		allaMD = el.$('.ng-binding').getText();
		assert(allaMD !== '0', 'There are no post in list');
		callback();
	});

	this.When(/^the user add a searchcriteria$/, function (callback) {
		searchfilter.selectCategory("EKONOMI");
		callback();
	});

	this.Then(/^the number of posts in the result lists is reduced$/, function (callback) {
		browser.driver.sleep(3000);
		var el = element(by.css('span.result-text'));
		assert(allaMD !== el.$('.ng-binding').getText(), 'The number of hites are the same');
		callback();
	});

	this.Given(/^the list is collapsed$/, function (callback) {

		browser.driver.manage().window().maximize();
		list.setCompactViewResult;
		list.resultList.get(0).element(by.xpath("//*[contains(text(),'abstract')]")).isDisplayed().then(function (a) {
			assert.isFalse(a, 'Result table is not collapsed');
		});
		callback();
	});

	this.When(/^the user clicks the button to show the result list expanded$/, function (callback) {
		list.setFullViewResult;
		callback();
	});

	this.Then(/^the result list is expanded$/, function (callback) {
		list.resultList.get(0).element(by.xpath("//*[contains(text(),'abstract')]")).isDisplayed().then(function (a) {
			assert.isTrue(a, 'Result table is not expanded');
		});
		callback();
	});
	this.When(/^the user clicks the button to show the result list collapsed$/, function (callback) {
		list.setCompactViewResult;
		callback();
	});

	this.Then(/^the result list is collapsed$/, function (callback) {
		list.resultList.get(0).element(by.xpath("//*[contains(text(),'abstract')]")).isDisplayed().then(function (a) {
			assert.isFalse(a, 'Result table is not collapsed');
			callback();
		});
	});

	this.Given(/^that the list does not contains any metadata posts$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user enters a search criteria$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^the result is displayed in the result list$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user clicks the button to sortera efter A\-Ö$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^the result list is sorterad A\-Ö$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^the result list is sorterad Ö\-A$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user clicks the button to visa tackningsyta for a post$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^the map is shown$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^in the map the tackningsyta is shown$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user clicks the button to show Mer information$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^what\?$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user clicks the button to visa pa karta for a post$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^in the map the metadata post is shown$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Given(/^that there are rekommenderade datasamlingar$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user clicks a picture with rekommenderade datasamlingar$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^the rekommenderade datasamlingar for the picture is shown$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user clicks the button to sortera efter Ö\-A$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Given(/^that the result list contains more than (\d+) posts$/, function (arg1, callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user clicks the button to fetch more$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.Then(/^the list is updated to show next page with results$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});

	this.When(/^the user clicks the button to hamta datamangd for a post$/, function (callback) {
		// Write code here that turns the phrase above into concrete actions
		callback(null, 'pending');
	});
}
