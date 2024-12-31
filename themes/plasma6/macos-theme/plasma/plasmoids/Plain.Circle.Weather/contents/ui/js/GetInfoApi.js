function obtenerDatosClimaticos(latitud, longitud, callback) {
     let url = `https://api.open-meteo.com/v1/forecast?latitude=${latitud}&longitude=${longitud}&current=temperature_2m,is_day,weather_code&timezone=auto`;

     let req = new XMLHttpRequest();
     req.open("GET", url, true);

     req.onreadystatechange = function () {
         if (req.readyState === 4) {
             if (req.status === 200) {
                 let datos = JSON.parse(req.responseText);
                 let currents = datos.current;
                 let isday = currents.is_day

                 let temperaturaActual = currents.temperature_2m;
                 let codeCurrentWeather = currents.weather_code;

                 let full = temperaturaActual + " " + codeCurrentWeather + " " + isday
                 console.log(`${full}`);
                 callback(full);
             } else {
                 console.error(`Error en la solicitud: ${req.status}`);
             }
         }
     };

     req.send();
 }

