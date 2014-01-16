

<?xml version="1.0" encoding="UTF-8"?>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
  <title>foursquare :: Explore Sample</title>
  
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript" id="jquery"></script>
  
 
  <link href="/styles/leaflet.css" type="text/css" rel="stylesheet" />
  <link href="/styles/apisamples.css" type="text/css" rel="stylesheet" />
 
  <script src="/scripts/apisamples.js" type="text/javascript"></script>
  <script src="/scripts/third_party/jquery.ba-bbq.js" type="text/javascript"></script>
  <script src="/scripts/third_party/leaflet.js" type="text/javascript"></script>
  <script src="/scripts/third_party/wax.leaf.min.js" type="text/javascript"></script>
 
  <style type="text/css">
    html { height: 100%; }
    body { height: 100%; margin: 0; padding: 0; }
    /* Give our markers a background image */
    .leaflet-marker-icon {
      background: url(https://foursquare.com/img/pin-blue-transparent.png);
      padding: 6px;
      padding-bottom: 17px;
      top: -6px;
      left: -6px;
      }
  </style>
 
  <script type="text/javascript">
  
  var config = {
    apiKey: 'XXXXXXXXXXXXXX',
    authUrl: 'https://foursquare.com/',
    apiUrl: 'https://api.foursquare.com/'
  };
  
 
  //<![CDATA[
  // Javascript will go here.
  //]]>
  </script>
 
  
</head>
<body>
  
<h5><%= @trip.name %></h5>
<div id="photos">
  <h1><%= @current_user.possessive_name %> recent photos:</h1>
  <%= @photos ? render(@photos) : "There are no photos available." %>
</div>
<div id="tweet">
 <%= @statuses ? render(@statuses) : "There are no statuses available." %>
</div>
  <div style="width: 100%; height: 100%;" id="map_canvas"></div>
</body>
</html>  
