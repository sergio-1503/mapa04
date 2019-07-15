<%@page import="entidad.ubicacion"%>
<%@page import="controller.ubicacionController"%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
    </style>
   <title>Map Search</title>
     <meta charset="utf-8">
     <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

     <!-- Add references to the Azure Maps Map control JavaScript and CSS files. -->
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
     <link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css">
     <script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>

     <!-- Add a reference to the Azure Maps Services Module JavaScript file. -->
     <script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas-service.min.js"></script>
    <script>
                 <%
                    ubicacionController cont = new ubicacionController();
                    ubicacion aux = new ubicacion();
                    aux= cont.obt();
                %>
          var lati = <%=aux.getLat()%>;
          var long= <%=aux.getLongi()%>;
          var myLatLng ;
            var mapOptions;
            var map  ;
          var marker  ;

        function GetMap(){
                 map = new atlas.Map("map", {
              //Add your Azure Maps subscription key to the map SDK. Get an Azure Maps key at https://azure.com/maps
              authOptions: {
                  authType: 'subscriptionKey',
                  subscriptionKey: 'VsKX5wcTpZnq8jElj_VtiBsLgn3Oa_Y9WSf9wL8zZao'
              }
            });
                  map.events.add('ready', function () {

                  //Create a HTML marker and add it to the map.
                  marker = new atlas.HtmlMarker({
                    color: 'DodgerBlue',
                    text: 'O',
                    position: [long, lati],
                  });
                  
                  map.markers.add(marker);
                  
                });
             }
        </script>
  </head>
  <body onload="GetMap()">
    
    <input id="latitud" name="prodId" type="hidden" >
    <input id="longitud" name="prodId" type="hidden">
    <div id="map"></div>
   <script>
    
    
    function latitu(){
        
        var a;
        $.ajax({
                url: "buscarServlet",
                
                success: function(respuesta) {
                    a=respuesta;
                    $('#latitud').val(a);
                },
                
            
        });
        
       
    }
    function longi(){
        
        var b;
        $.ajax({
                url: "buscarServlet1",
                
                success: function(respuesta) {
                    b=respuesta;
                    $('#longitud').val(b);
                },
                
            
        });
        
       
    }
    
    function change() {
        latitu();
        longi();
        var a= document.getElementById('latitud').value;
        var b= document.getElementById('longitud').value;
        
        
        lati=a;
        long=b;
        console.log(lati);
        console.log(long);
        map.markers.clear();
        marker= new atlas.HtmlMarker({
                    color: 'DodgerBlue',
                    text: 'O',
                    position: [long, lati],
                  });
        map.markers.add(marker);

            
    }
    
    
    
    setInterval(change, 500);
    </script>
    
  </body>
</html>