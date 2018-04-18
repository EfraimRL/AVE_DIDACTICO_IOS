
//AddStep...Para guardar los pasos        //Buscar como guardar los pasos, en texto
//AddTable..Grafica los pasos             //Guardar el arreglo en formato JSON para devolverlo


// Products Table Angular App
angular.module('productsTableApp', [])

// create a controller for the table
.controller('ProductsController', function($scope){
  // initialize the array
    var Pasos = []
  $scope.showD = "visible";
  $scope.widthD = "135px";
  $scope.metodoinput="";
  var columnastxt="";
  var tablehead="<th width='50px'></th>";
  var algdev = ""; var step = 0;
  var tfg = 0, bfg=0;
  //Total de fabricas y bodegas 

  $scope.data=
    [
      [{valor:"0"}],
      [{valor:"0"}],
      [{valor:"0"}],
      [{valor:"0"}],
      [{valor:"0"}]
    ];

  //Complete Table and disabled buttons.
  $scope.completeTable = function(){
    //$scope. = "red";
    $scope.data.forEach(function($row){
      $row.push({valor:"0",cellcolor: '#EFED7A'})
    });
     // create a blank array
    var newrow = [];
     
      // if array is blank add a standard item
      if ($scope.data.length === 0) {
        newrow = [{valor:'0'}];
      } else {
        // else cycle thru the first row's columns
        // and add the same number of items
        $scope.data[0].forEach(function (row) {
          newrow.push({valor :'0',cellcolor: '#EFED7A'} );
        });
      }
    // add the new row at the end of the array 
    $scope.data.push(newrow);
     $scope.showD = "hidden";
     $scope.widthD = "0px";//Agregar el siguiente paso
    //$('#Pleccion').append('<p>Como se puede observar, se agregaron campos extra para ingresar la oferta/demanda. </p>');
    addStep(' Como se puede observar, se agregaron campos extra para ingresar la oferta/demanda.');addTable();
    //algdev = algdev +'<table id="DataFab"  class="table table-bordered"><thead><tr></tr></thead><tr class="headerColumn"></tr><tr ng-repeat="datum in data"><th width="50px">F{{$index}} </th><td ng-repeat="field in datum"><p type="text" style="background-color: {{field.cellcolor}}"ng-model="field.costo"s>{{field.costo}}</p></td></tr></table>'; 
    $( ".btnDP").hide();
    $( ".btnD3").show();
    $scope.metodoinput="doBalance()";
    //$('#PleccionR').append(algdev);
  }

  //Valida total de demandas == total de ofertas
  $scope.doBalance = function(){
    //$scope.data[0,0].push({valor :'0',cellcolor: '#EFED7A'} );
    //$('#PleccionR').html('');
    //console.log($scope.data);
    var nf = 0; //Numero  de la fábrica
    var tf = 0, bf=0;//Almacena el total de Oferta y Demanda
    var nb = 0; //Numero de bodega
    //console.log($scope.data.length);

    //Busca todas las ofertas y las demandas, y las suma.
    angular.forEach($scope.data,function(value,index){
      var long = value.length;
      for(i = 0; i< long;i++) {//var i in value
        if ((index + 1 ) < $scope.data.length ) {
          if (i == long -1 ){ 
            nf++;
            //$('#PleccionR').append('<p>La oferta de la Fábrica #' + nf + ' es ' +  value[i].valor + '</p>');
            tf = tf +  parseInt(value[i].valor);
          }      
        }
        else{                    
          if(i < long -1){ 
            nb++;
            //$('#PleccionR').append('<p>La demanda de la Bodega #' + nb + ' es ' +  value[i].valor + '</p>');
            bf = bf +  parseInt(value[i].valor);
          }                       
        }
      }
    });           
    //addStep(' Se prosigue a realizar el balance entre el total de las fabricas y bodegas <b>('+tf+' (Fabricas) / '+bf+' (Bodegas)</b>).');
    //$('#PleccionR').append('<br><p> El balance es '+ tf +'(Fabricas)/'+ bf +'(Bodegas)</p>');
    
    /*-Filas -> busca Fila por fila, renglon por renglon buscando la ultima celda, 
    valida que los totales de demanda y oferta son diferntes de 0, tambien que sean iguales entre si
    para asignar ese valor. Si no, marca el color de la celda*/
    angular.forEach($scope.data,function(value,index){
      var columnas = value.length;
      var renglones = $scope.data.length;
      //Columnas
      angular.forEach(value, function(val, indo) {
        if ((indo + 1)== columnas && (index + 1 ) == renglones && (tf != 0 && bf != 0)){
          if(tf==bf){
            //$('#PleccionR').append('<br><p>Esta balanceado</p>');
            //addStep('<b style="color:#16b73b;"> Esta balanceado.</b>');addTable();
            val.valor = tf + '/' + bf;
            val.cellcolor = '#aaf74c';
          }
          else{
            //$('#PleccionR').append('<br><p>NO Esta balanceado</p>');
            //addStep('<b>No esta balanceado.</b>');addTable();                      
            val.valor = tf + '/' + bf;
            val.cellcolor = '#EFED7A';
          }
        }
      });
    });
    //Asigna los resultados de los totales a variables globales.
    tfg = tf; bfg=bf;
  }

  $scope.doAssigment = function (){
        addStep(' Se prosigue a realizar el balance entre el total de las fabricas y bodegas <b>('+tfg+' (Fabricas) / '+bfg+' (Bodegas)</b>).');addTable();
          //$scope.metodoinput="";
          columnastxt= "<td width='50px'></td>";
          var rows; var columns; var df = 0; var db = 0;
          $scope.data.forEach(function($row){
            columns =  $row.length - 1;
          });
          rows =  $scope.data.length - 1;
        if(tfg==bfg){addStep('<b style="color:#16b73b;"> Esta balanceado.</b>');}
        //Agrega una celda en cada renglon...Formando la columna que falta
        if(tfg>bfg){
          addStep('<b style="color:#ea1221;">No esta balanceado.</b> Se agrega una bodega ficticia.');
          $scope.data.forEach(function($row){
            $row.splice(0,0,{valor:"0", cellcolor: '#e5b5f2'})
          });
          columns++;
          $scope.data[rows][0].valor = tfg-bfg;
          $scope.doBalance(); 
//AddTable
          addTable(); 
        }
        //Agrega un renglon al final
        if(bfg>tfg){   
          addStep('<b style="color:#ea1221;">No esta balanceado.</b> Se agrega una fábrica ficticia.');
          //console.log("Mas bodega");     
          var newrow = [];     
          // if array is blank add a standard item
          if ($scope.data.length === 0) {
            newrow = [{'F':''}];
          }
          else {
            // else cycle thru the first row's columns
            // and add the same number of items
            $scope.data[0].forEach(function (row) {
              newrow.push({valor :'0', cellcolor: '#e5b5f2'});
            });
          }
          // add the new row at the end of the array 
          $scope.data.splice(rows,0,newrow); rows++;$scope.data[rows-1][columns].valor = bfg-tfg;$scope.doBalance();
//AddTable
          addTable();  
        }                     
//Aqui hace el trabajo
        for( var i = 0; i < columns ; i++ ){
          columnastxt = columnastxt + "<th>B" + i + "</th>";
          for (var j = 0; j < rows; j++){   
            //Toma el valor de la demanda y oferta de la celda en la que se encuentra
            df =  parseFloat($scope.data[j][columns].valor);
            db =  parseFloat($scope.data[rows][i].valor);  
            console.log("Renglon: " + $scope.data[j][i].valor + " r#" + i+", c#" + j + "\n Demanda F: " + df + " . DB: " + db );
            //Si la demanda de la fabrica es 0
            if(df==0){
              $scope.data[j][i].cellcolor = "#e8ff9e";
              addStep('Al llegar a esta celda notamos que la fabrica ya agoto su oferta, por lo que pasamos de ella.');
//AddTable              
              addTable(); $scope.data[j][i].cellcolor='#FFF';
            }//Quemamos la celda
            //Si la oferta de la bodega es 0
            else if(db==0){
              $scope.data[j][i].cellcolor = "#e8ff9e";
              addStep('Al llegar a esta celda notamos que la bodega ya agoto su demanda, por lo que pasamos de ella por completo.');
//AddTable              
              addTable(); $scope.data[j][i].cellcolor='#FFF';
              j = rows; break;
            }
            //Si hay demanda y oferta
            else{ 
              var smallerindex = parseFloat(getShippestCell(rows,i));
              //console.log( columns + "C/r. " + rows);             
              //console.log("Renglon: " + $scope.data[j][i].valor + " r#" + i+", c#" + j + "\n Demanda F: " + df + " . DB: " + db );

              //La demanda de la bodega es mas grande que la de la fabrica
              if(db>df && j==smallerindex){
                //$scope.data[j][i].costo = df;//Asignamos el valor de la bodega a la celda
                $scope.data[smallerindex][i].costo = df;//Asignamos el valor de la bodega a la celda con el valor de costo mas chiquito
                $scope.data[rows][i].valor = db-df;
                $scope.data[rows][i].costo = db-df;
                  $scope.data[smallerindex][columns].costo = 0;
                $scope.data[smallerindex][columns].valor = 0; j=-1;
                $scope.data[smallerindex][i].cellcolor = "#e8ff9e";
                addStep('La demanda de la bodega es mas grande que de la fábrica. Por lo tanto, asignamos la diferencia entre la bodega y la fábrica (valor menor entre bodega-fábrica) a esta celda. El valor resultante de la disyunción entre la bodega y la fábrica es asignado al total de la fábrica.');
//AddTable                
                addTable(); $scope.data[smallerindex][i].cellcolor='#FFF';
              }

              //La demanda de la fabrica es mas grande que la de la bodega
              else if(df>db && j==smallerindex){
                //$scope.data[j][i].costo = db;//Asignamos el valor de la fabrica a la celda
                $scope.data[smallerindex][i].costo = db;//Asignamos el valor de la fabrica a la celda con el valor de costo mas chiquito
                $scope.data[smallerindex][columns].valor = df-db;
                $scope.data[smallerindex][columns].costo = df-db;
                $scope.data[rows][i].valor = 0;j=-1;
                $scope.data[rows][i].costo = 0;
                $scope.data[smallerindex][i].cellcolor = "#e8ff9e";
                addStep('La demanda de la fábrica es mas grande que de la bodega. Por lo tanto, asignamos la diferencia entre la bodega y la fábrica (valor menor entre bodega-fábrica) a esta celda. El valor resultante de la disyunción entre la fábrica y la bodega es asignado al total de la bodega.');
//AddTable                
                addTable(); $scope.data[smallerindex][i].cellcolor='#FFF';
              }

              //La demanda de la fabrica es igual que la de la bodega
              else if(db==df && j==smallerindex){
                $scope.data[smallerindex][i].costo = df;//Asignamos el valor del que sea
                $scope.data[rows][i].valor = 0;
                $scope.data[rows][i].costo = 0
                $scope.data[smallerindex][columns].valor = 0;j=-1;
                $scope.data[smallerindex][columns].costo = 0;
                $scope.data[smallerindex][i].cellcolor = "#e8ff9e";
                addStep('Son iguales, se toma el primero.');
//AddTable                
                addTable(); $scope.data[smallerindex][i].cellcolor='#FFF';
              }
            }
               // console.log("El valor mas pequeño es : " + getShippestCell(rows,i));                                      
          }  
          addStep('<b>Este es el resultado final</b>');
//AddTable          
          addTable();              
        }
        $('.headerColumn').append(columnastxt);
        $('#PleccionR').append(algdev);
  }

  //Devuelve el indice del menor valor de las bodegas que sea distinto de 0
  function getShippestCell(rows,column){
    var smaller = 78124999999999965;//parseFloat($scope.data[0][column].valor);
    var columns = 0;
      $scope.data.forEach(function($row){
      columns =  $row.length - 1;
      });
    var smallerindex = 0; 
    //Toma el menor valor de las bodegas
    for(var i=0;i<rows;i++){
      //Oferta de la bodega
      var db =  parseFloat($scope.data[i][columns].valor); 
      //console.log("El valor total de este renglon es: " + $scope.data[i][column].valor + ',db:'+ db);
      var value =  parseFloat($scope.data[i][column].valor);
      var costo =  parseFloat($scope.data[i][column].costo);
      if(value<smaller && (!costo) && db>0){smaller = value;smallerindex=i;}  //costo>=0
    }
    return smallerindex;
  }
            
       /*angular.forEach($scope.data,function(value,index){
                console.log(value.v);
        })*/
  
	
  //--------------------------------FUNCIONES DE TEXTO----------------------------
  function addStep(text){step++;algdev = algdev + '<br><p><b>#'+ step +':</b>'+ text +'</p>';}
  
  function addTable(){
    var rows; var columns;
    tablehead="<th width='50px'></th>";

    //Establece el tama;o de las columnas
     $scope.data.forEach(function($row){
     columns =  $row.length - 1;
     });
    //Establece el tama;o de los renglones
    rows =  $scope.data.length - 1;

    //Inicia la tabla
    algdev = algdev +"<table id='DataFab' class='table table-bordered'><thead><tr><th width='50px'></th>";
    
    //Dibuja cada columna de un renglon
    for( var i = 0; i < columns; i++){algdev = algdev + '<th>B' + i + '</th>';}
    algdev = algdev +"<th>BT</th></tr></thead>";
    
    for( var i = 0; i <= rows ; i++ ){
      //Si es el ultimo renglon pone FT (Fabrica total)
      if(i==rows){
        algdev = algdev +"<tr><th width='50px'>FT</th>";
      }
      else{
        algdev = algdev +"<tr><th width='50px'>F" + (i+1) + "</th>";
      }


      for (var j = 0; j <= columns; j++){
        //Si es el primer renglon y la ultima columna: Pone BT (Bodega Total)
        if(i==0 && j==columns){
          tablehead = tablehead + '<th>BT</th>';
        }
        else{
          tablehead = tablehead + '<th>B'+(j+1)+'</th>';
        }
        //Si es el ultimo renglon y la ultima columna.
        if(i==rows || j==columns){
          algdev = algdev +"<td style='background-color:#EFED7A'><b>"+$scope.data[i][j].valor+"</b></td>";
        }
        else{
          if($scope.data[i][j].costo){
            algdev = algdev +"<td style='background-color:"+ $scope.data[i][j].cellcolor + ";'><b>"+$scope.data[i][j].costo+"</b>($"+$scope.data[i][j].valor+")</td>";
          }
          else{
            algdev = algdev +"<td><b>($"+$scope.data[i][j].valor+"</b>)</td>";
          }
        }
      }
      algdev = algdev +"</tr>";
    }
    algdev = algdev + "</table>";
    //algdev = algdev +"<table id='DataFab' class='table table-bordered'><thead><tr></tr></thead><tr class='headerColumn'></tr><tr ng-repeat= datum in"+ $scope.data +  "><th width='50px'>F $index </th><td ng-repeat='field in datum'><p type='text' style='background-color: field.cellcolor' ng-model=field.costo'>"+$scope.data.costo+"</p></td></tr></table>"; 
  }

});


