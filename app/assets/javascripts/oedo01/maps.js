  function initialize() {
    var latlng = new google.maps.LatLng(35.681701,139.800618);
    var myOptions = {
      zoom: 15,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

	var markerlatlng = new google.maps.LatLng(35.681701,139.800618)
	var marker = new google.maps.Marker({
	      position: markerlatlng, 
	      map: map, 
	      title:"Here!"
	  });
  
	  marker.setMap(map);
    }