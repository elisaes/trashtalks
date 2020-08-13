handler = Gmaps.build('Google');  
handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){  
    let lists = $('.lists').data("lists")
    lists.forEach( li => {
        markers = handler.addMarkers([  
            {  
            "lat": li.latitude, 
            "lng": li.longitude,  
            "picture": {  
                "width":  32,  
                "height": 32  
            },
            "infowindow": li.address
            }  
        ]);  
        handler.bounds.extendWith(markers);  
        handler.fitMapToBounds();  
    })
});  