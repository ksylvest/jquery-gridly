# jQuery Gridly

Gridly is a jQuery plugin to enable dragging and dropping as well as resizing on a grid.

## Installation

To install copy the *javascripts* and *stylesheets* directories into your project and add the following snippet to the header:

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>
    <script src="javascript/jquery.gridly.js" type="text/javascript"></script>
    <link href="stylesheets/jquery.gridly.css" rel="stylesheet" type="text/css" />

This plugin is also registered under http://bower.io/ to simplify integration. Try:

    npm install -g bower
    bower install gridly

Lastly this plugin is registered as a https://rails-assets.org/ to simplify integration with Ruby on Rails applications:

**Gemfile**

    + source 'https://rails-assets.org'
    ...
    + gem 'rails-assets-gridly'

**application.css**

    /*
     ...
     *= require gridly
     ...
    */

**application.js**

    //= require jquery
    ...
    //= require gridly

## Examples

Setting up a gridly is easy. The following snippet is a good start:

    <style>
      .brick.small {
        width: 140px;
        height: 140px;
      }

      .brick.large {
        width: 300px;
        height: 300px;
      }
    </style>

    <div class="gridly">
      <div class="brick small"></div>
      <div class="brick small"></div>
      <div class="brick large"></div>
      <div class="brick small"></div>
      <div class="brick small"></div>
      <div class="brick large"></div>
    </div>

    <script>
      $('.gridly').gridly();
    </script>

## Configuration

Gridly uses a fairly standard pattern for handling grids and offers three configuration options for sizing: *base*, *gutter* and *columns*:

    $('.gridly').gridly({
      base: 60, // px 
      gutter: 20, // px
      columns: 12
    });

When using the drag and drop sorting callbacks can be passed in when initializing:

    var reordering = function($elements) {
      // Called before the drag and drop starts with the elements in their starting position.
    };

    var reordered = function($elements) {
      // Called after the drag and drop ends with the elements in their ending position.
    };

    $('.wall .bricks').gridly({
      callbacks: { reordering: reordering , reordered: reordered }
    });

## Status

[![Status](https://travis-ci.org/ksylvest/jquery-gridly.png)](https://travis-ci.org/ksylvest/jquery-gridly)

## Copyright

Copyright (c) 2013 - 2013 Kevin Sylvestre. See LICENSE for details.
