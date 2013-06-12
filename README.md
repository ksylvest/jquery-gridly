# jQuery Gridly

Gridly is a jQuery plugin to enable dragging and dropping as well as resizing on a grid.

## Installation

To install copy the *javascripts* and *stylesheets* directories into your project and add the following snippet to the header:

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js" type="text/javascript"></script>
    <script src="javascript/jquery.gridly.js" type="text/javascript"></script>
    <link href="stylesheets/jquery.gridly.css" rel="stylesheet" type="text/css" />

## Examples

Setting up a gridly is easy. The following snippet is a good start:

    <div class="gridly">
      <div class="brick small"></div>
      <div class="brick small"></div>
      <div class="brick large"></div>
      <div class="brick small"></div>
      <div class="brick small"></div>
      <div class="brick large"></div>
    </div>
    <script>
      $('.gridly').gridly()
    </script>

## Copyright

Copyright (c) 2013 - 2013 Kevin Sylvestre. See LICENSE for details.
