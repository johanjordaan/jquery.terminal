should = require('chai').should()
expect = require('chai').expect

global.window = require('jsdom').jsdom().createWindow()
global.jQuery = require('jquery')

global.navigator  = {}
global.navigator.userAgent = "TestAgent"

terminal = require('../js/jquery.terminal-src')


tests = [
  { fmt: 'Hallo %s!', args: ['World'] , res: 'Hallo World!' }
  { fmt: 'Some Binary %b!', args: [15] , res: 'Some Binary 1111!' }
]  

describe 'sprintf', () ->
  it 'should exist after import', () ->
    expect(terminal.sprintf).to.exist

  describe 'should return formatted strings based on the formats', () ->
    for test in tests
      it "should parse #{test.fmt}, to #{test.res}", () ->
        args = test.args.slice(0)
        args.unshift(test.fmt)
        terminal.sprintf.apply(@,args).should.equal(test.res) 
   
describe 'vsprintf', () ->
  it 'should exist after import', () ->
    expect(terminal.vsprintf).to.exist

  describe 'should return formatted strings based on the formats', () ->
    for test in tests
      it "should parse #{test.fmt}, to #{test.res}", () ->
        terminal.vsprintf(test.fmt,test.args).should.equal(test.res) 
    