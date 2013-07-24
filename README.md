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
      columns: 12,
    });

When using dragging the handle (element that responds to drag events) can be changed as well:

    $('.gridly').gridly({
      draggable: { handle: '.move' }
    });

## Copyright

Copyright (c) 2013 - 2013 Kevin Sylvestre. See LICENSE for details.
