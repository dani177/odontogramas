<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src='<%=request.getContextPath()%>/js/jquery.reel-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.disabletextselect-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.mousewheel-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.cookie-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/sampler.js' type='text/javascript'></script>
<style type="text/css">
    .diente{
        cursor: pointer;
    }
</style>
<script type="text/javascript">
    $(function(){
   
        $('.ultima').datepicker();        
        $('.fecha').datepicker();        
        
        $(".diente").click(function(ev){
            if($("#derecha").css("display")=="none"){
                $("#derecha").show();
            }
            $("#dienteSeleccionado").text("Diente "+ $(this).attr("id"));
        });
        
        $(".parte").click(function(ev){
            alert($(this).attr("id"));
        });
        
        
        $("#agregarEvol").click(function(){
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarEvolucion",
                data: $("#formEvol").serialize(),
                success: function(){
                    $("#tablaEvol").prepend("<tr>"
                        +"<td>"+$("#fechaE").val()+"</td>"
                        +"<td>"+$("#reciboE").val()+"</td>"
                        +"<td>"+$("#tratamientoE").val()+"</td>"
                        +"<td>"+$("#codigoTratE").val()+"</td>"
                        +"</tr>  ");
                    $("fechaE").val("");
                    $("#reciboE").val("");
                    $("#tratamientoE").val("");
                    $("#codigoTratE").val("");
                    
                } //fin success
            }); //fin $.ajax    
            
        }) ;
        $("#agregarDiag").click(function(){
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarDiagnostico",
                data: $("#formDiag").serialize(),
                success: function(){
                    $("#tablaDiag").prepend("<tr>"
                        +"<td>"+$(".textareaDiagnostico").val()+"</td>"
                        +"<td>"+$("#inputCodigoDiag").val()+"</td>"
                        +"</tr>  ");
                    $(".textareaDiagnostico").val("");
                    $("#inputCodigoDiag").val("");
                    
                } //fin success
            }); //fin $.ajax    
            
        }) ;
        
        
        $("#agregarTrat").click(function(){
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarTratamiento",
                data: $("#formTrata").serialize(),
                success: function(){
                    $("#tablaTrat").prepend("<tr>"
                        +"<td>"+$("#codTrat").val()+"</td>"
                        +"<td>"+$(".textareaTratamiento").val()+"</td>"
                        +"<td>"+$("#presTrat").val()+"</td>"
                        +"</tr>  ");
                    $("#codTrat").val("");
                    $(".textareaTratamiento").val("");
                    $("#presTrat").val("");
                    
                } //fin success
            }); //fin $.ajax    
            
        }) ;

        
        
        var miArray2 = new Array(${tratamientos.size()});
        
    <c:forEach items="${tratamientos}" var="item2" varStatus="iter2">
            miArray2[${iter2.index}] = "${item2.getTratamiento()}";
    </c:forEach> 
        
            $(".textareaTratamiento").typeahead({
                source:miArray2 
            });
            
        
            var miArray = new Array(${diagnosticos.size()});
        
    <c:forEach items="${diagnosticos}" var="item" varStatus="iter">
            miArray[${iter.index}] = '${item.getDiagnostico()}';
    </c:forEach> 
        
            $(".textareaDiagnostico").typeahead({
                source:miArray 
            });
            
            $("#datos2").validate({
                submitHandler: function(){
                    $.ajax({
                        type: 'POST', 
                        url: "<%=request.getContextPath()%>/formController?action=guardarDatosBasicos",
                        data: $("#datos2").serialize(),
                        success: function(){
                            $("a[href='#otro']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });    
            
            $("#formPron").validate({
                submitHandler: function(){
                    $.ajax({
                        type: 'POST', 
                        url: "<%=request.getContextPath()%>/formController?action=guardarPron",
                        data: $("#formPron").serialize(),
                        success: function(){
                            // $("a[href='#otro']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });    
            
            
            
            $("#datos3").validate({
                submitHandler: function(){
                    $.ajax({
                        type: 'POST', 
                        url: "<%=request.getContextPath()%>/formController?action=guardarDatosBasicos2",
                        data: $("#datos3").serialize(),
                        success: function(){
                            $("a[href='#diag']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });    
            
            
            
            $.reel.def.indicator= 5;

            $('.sample img[id]').each(function(){

                prepare_reel_sample('#' + $(this).attr('id'));
                /*
    This `prepare_reel_sample` essentialy uses each sample's options
    and passes them to `.reel` call as a parameter when clicked.
    It also adds some UI interactions like toggling samples, cookie persistence and such.
    Definitely not needed for running Reel itself. You DON'T want to use it.

    You simply do:
      $('#my_image').reel({ ..your options.. });

    Just like that.
                 */
            });

            /*
  Cookie persistence of last selected sample. You DON'T want to use this either.
             */
            $($.cookie('reel.test.sample') || '.sample:first').click();

            
            
        }); //fin function
</script>


<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div>
    <ul id="tab" class="nav nav-tabs">
        <li class="active"><a href="#profile" data-toggle="tab">I. Datos Basicos</a></li>
        <li ><a href="#otro" data-toggle="tab">II. Examen Fisico Estomatologico</a></li>
        <li ><a href="#odonto" data-toggle="tab">III. Odontograma</a></li>
        <li ><a href="#diag" data-toggle="tab">IV. Diagnostico Y Tratamiento </a></li>
    </ul>




    <!-------------PESTANA 1--------------------------------------------->
    <div id="myTabContent" class="tab-content">
        <!------------------PESTANA 2------------------------------------------>
        <div class="tab-pane fade in active " id="profile">
            <!--nuevo2-->

            <div class="span12">
                <form class="form-horizontal" id="datos2" method="post">
                    <fieldset>
                        <legend>II. Datos Personales</legend>
                        <div class="control-group">
                            <label for="motivo" class="control-label">Motivo de la consulta</label>
                            <div class="controls">
                                <textarea rows="3" id="motivo" name="motivo" class="input-xxlarge {required:true}"></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="historia" class="control-label">Historia de la enfermedad actual</label>
                            <div class="controls">
                                <textarea rows="3" id="historia" name="historia" class="input-xxlarge {required:true}"></textarea>
                            </div>
                        </div>       
                        <table class="table table-striped table-bordered table-condensed">
                            <thead>
                                <tr>
                                    <th>Datos Basicos</th>
                                    <th>Si</th>
                                    <th>No</th>
                                    <th>No Sabe</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${datosBasicos}" var="row">
                                    <tr>
                                        <td>${row.nombre}</td>
                                        <td> <input type="radio" value="si" name="${row.nombre}" ></td>
                                        <td> <input type="radio" value="no" name="${row.nombre}" ></td>
                                        <td> <input type="radio" value="no sabe" name="${row.nombre}" checked></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>


                        <div class="control-group">
                            <label for="observaciones" class="control-label">Observaciones</label>
                            <div class="controls">
                                <textarea rows="3" id="observaciones" name="observaciones" class="input-xxlarge  {required:true}"></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="otros" class="control-label">Otros</label>
                            <div class="controls">
                                <textarea rows="3" id="otros" name="otros" class="input-xxlarge"></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="ultima" class="control-label">Ultima Visita al odontologo</label>
                            <div class="controls">
                                <input type="text" id="ultima" name="ultima" class="input-medium ultima" data-datepicker="datepicker">
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="motivo2" class="control-label">Motivo</label>
                            <div class="controls">
                                <textarea rows="3" id="motivo2" name="motivo2" class="input-xxlarge"></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="docentes" class="control-label">Docente</label>
                            <div class="controls">
                                <select name="docente" class="{required:true}">
                                    <option selected="selected"></option> 
                                    <c:forEach items="${docentes}" var="row" varStatus="iter">
                                        <option value="${row.iddocente}">${row.nombre}</option>    
                                    </c:forEach>

                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button class="btn btn-primary" type="submit">Guardar cambios</button>
                            <button class="btn" type="reset">Cancelar</button>
                        </div>
                    </fieldset>
                </form>
            </div> <!--/span-->

            <!--/nuevo2-->

        </div>



        <!-----------------PESTANA 3---------------------------->
        <div class="tab-pane fade" id="otro">

            <div class="span12">
                <form class="form-horizontal" id="datos3">
                    <fieldset>
                        <legend>III. Examen Fisico Estomatologico</legend>
                        <div class="control-group">
                            <label for="temperatura" class="control-label">Temperatura</label>
                            <div class="controls">
                                <input id="temperatura"  name="temperatura" type="text" >
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="pulso" class="control-label">Pulso</label>
                            <div class="controls">
                                <input id="pulso" name="pulso"  type="text" >
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="tension" class="control-label">Tension A.</label>
                            <div class="controls">
                                <input id="tension" name="tension" type="text" >
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Higiene Oral</label>
                            <div class="controls">
                                <select id="higiene" name="higiene">
                                    <option value="Buena">Buena</option>
                                    <option value="Regular">Regular</option>
                                    <option value="Mala">Mala</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Uso de seda dental</label>
                            <div class="controls">
                                <select id="usoSeda" name="usoSeda">
                                    <option value="Si">Si</option>
                                    <option value="No">No</option>
                                    <option value="Aveces">Aveces</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Cepillo dental:Uso</label>
                            <div class="controls">
                                <select id="cepillo" name="cepillo">
                                    <option value="Si">Si</option>
                                    <option value="No">No</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Cuantas veces al dia</label>
                            <div class="controls">
                                <select id="veces" name="veces">
                                    <option value="0">0</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Uso de Enjuages Bucales sin fluor</label>
                            <div class="controls">
                                <select id="enjuages1" name="enjuages1">
                                    <option value="Si">Si</option>
                                    <option value="No">No</option>
                                    <option value="Aveces">Aveces</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"> Uso de Enjuages Bucales con fluor</label>
                            <div class="controls">
                                <select id="enjuages2" name="enjuages2">
                                    <option value="Si">Si</option>
                                    <option value="No">No</option>
                                    <option value="Aveces">Aveces</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Habitos y vicios</label>
                            <div class="controls">
                                <select id="habitosYvicios" name="habitosYvicios">
                                    <option></option>
                                    <option value="Tabacos">Tabacos</option>
                                    <option value="Alcohol">Alcohol</option>
                                    <option value="Caf&eacute;">Caf&eacute;</option>
                                    <option value="Drogas">Drogas</option>
                                    <option value="Otro">Otro</option>
                                    <option value="Ninguno">Ninguno</option>

                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button class="btn btn-primary" type="submit">Guardar cambios</button>
                            <button class="btn" type="reset">Cancelar</button>
                        </div>
                    </fieldset>
                </form>

            </div><!--span12--> 

        </div>

        <!-----------------PESTANA 4---------------------------->
        <div class="tab-pane fade" id="odonto">
            <div class="span12">
                <form class="form-horizontal" id="odo" method="post">
                    <fieldset>
                        <legend>Odontograma</legend>
                        <div class="row">
                            <div class="span6">   
                                <svg style="width: 450px; height: 500px;" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
                                <image xlink:href="<%=request.getContextPath()%>/images/diagrama.gif" height="479" width="340" y="20" x="20"/>





                                <circle class="diente" id="1" style="fill:transparent" r="12" cy="222" cx="45"></circle>
                                <circle class="diente" id="2" style="fill:transparent" r="12" cy="192" cx="45"></circle>
                                <circle class="diente" id="3" style="fill:transparent" r="12" cy="162" cx="50"></circle>
                                <circle class="diente" id="4" style="fill:transparent" r="12" cy="134" cx="63"></circle>
                                <circle class="diente" id="5" style="fill:transparent" r="12" cy="109" cx="82"></circle>
                                <circle class="diente" id="6" style="fill:transparent" r="12" cy="89" cx="107"></circle>
                                <circle class="diente" id="7" style="fill:transparent" r="12" cy="75" cx="136"></circle>
                                <circle class="diente" id="8" style="fill:transparent" r="12" cy="67" cx="169"></circle>
                                <circle class="diente" id="9" style="fill:transparent" r="12" cy="67" cx="202"></circle>
                                <circle class="diente" id="10" style="fill:transparent" r="12" cy="74" cx="233"></circle>
                                <circle class="diente" id="11" style="fill:transparent" r="12" cy="87" cx="263"></circle>
                                <circle class="diente" id="12" style="fill:transparent" r="12" cy="107" cx="288"></circle>
                                <circle class="diente" id="13" style="fill:transparent" r="12" cy="131" cx="308"></circle>
                                <circle class="diente" id="14" style="fill:transparent" r="12" cy="159" cx="322"></circle>
                                <circle class="diente" id="15" style="fill:transparent" r="12" cy="189" cx="327"></circle>
                                <circle class="diente" id="16" style="fill:transparent" r="12" cy="220" cx="330"></circle>


                                <circle class="diente" id="A" style="fill:transparent" r="12" cy="218" cx="105"></circle>
                                <circle class="diente" id="B" style="fill:transparent" r="12" cy="188" cx="105"></circle>
                                <circle class="diente" id="C" style="fill:transparent" r="12" cy="159" cx="117"></circle>
                                <circle class="diente" id="D" style="fill:transparent" r="12" cy="137" cx="140"></circle>
                                <circle class="diente" id="E" style="fill:transparent" r="12" cy="124" cx="170"></circle>
                                <circle class="diente" id="F" style="fill:transparent" r="12" cy="125" cx="203"></circle>
                                <circle class="diente" id="G" style="fill:transparent" r="12" cy="138" cx="233"></circle>
                                <circle class="diente" id="H" style="fill:transparent" r="12" cy="160" cx="256"></circle>
                                <circle class="diente" id="I" style="fill:transparent" r="12" cy="190" cx="266"></circle>
                                <circle class="diente" id="J" style="fill:transparent" r="12" cy="221" cx="268"></circle>

                                <circle class="diente" id="32" style="fill:transparent" r="12" cy="295" cx="45"></circle>
                                <circle class="diente" id="31" style="fill:transparent" r="12" cy="326" cx="46"></circle>
                                <circle class="diente" id="30" style="fill:transparent" r="12" cy="357" cx="52"></circle>
                                <circle class="diente" id="29" style="fill:transparent" r="12" cy="385" cx="65"></circle>
                                <circle class="diente" id="28" style="fill:transparent" r="12" cy="409" cx="84"></circle>
                                <circle class="diente" id="27" style="fill:transparent" r="12" cy="428" cx="110"></circle>
                                <circle class="diente" id="26" style="fill:transparent" r="12" cy="442" cx="138"></circle>
                                <circle class="diente" id="25" style="fill:transparent" r="12" cy="448" cx="171"></circle>
                                <circle class="diente" id="24" style="fill:transparent" r="12" cy="448" cx="204"></circle>
                                <circle class="diente" id="23" style="fill:transparent" r="12" cy="441" cx="236"></circle>
                                <circle class="diente" id="22" style="fill:transparent" r="12" cy="428" cx="266"></circle>
                                <circle class="diente" id="21" style="fill:transparent" r="12" cy="408" cx="290"></circle>
                                <circle class="diente" id="20" style="fill:transparent" r="12" cy="384" cx="310"></circle>
                                <circle class="diente" id="19" style="fill:transparent" r="12" cy="356" cx="323"></circle>
                                <circle class="diente" id="18" style="fill:transparent" r="12" cy="326" cx="328"></circle>
                                <circle class="diente" id="17" style="fill:transparent" r="12" cy="294" cx="328"></circle>


                                <circle class="diente" id="T" style="fill:transparent" r="12" cy="296" cx="105"></circle>
                                <circle class="diente" id="S" style="fill:transparent" r="12" cy="328" cx="106"></circle>
                                <circle class="diente" id="R" style="fill:transparent" r="12" cy="356" cx="117"></circle>
                                <circle class="diente" id="Q" style="fill:transparent" r="12" cy="378" cx="140"></circle>
                                <circle class="diente" id="P" style="fill:transparent" r="12" cy="391" cx="170"></circle>
                                <circle class="diente" id="O" style="fill:transparent" r="12" cy="392" cx="203"></circle>
                                <circle class="diente" id="N" style="fill:transparent" r="12" cy="380" cx="233"></circle>
                                <circle class="diente" id="M" style="fill:transparent" r="12" cy="358" cx="255"></circle>
                                <circle class="diente" id="L" style="fill:transparent" r="12" cy="329" cx="267"></circle>
                                <circle class="diente" id="K" style="fill:transparent" r="12" cy="297" cx="269"></circle>

                                </svg>
                            </div>
                            <div class="span6" id="derecha" style="display: none;">
                                <div class="row" style="text-align: center;">
                                    <h3 style="margin-left: -65px;" id="dienteSeleccionado"></h3>
                                    <svg style="width: 150px; height: 100px;" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
                                    <image xlink:href="<%=request.getContextPath()%>/images/diente.png" height="84" width="86" y="0" x="0"/> 

                                    <polygon class="parte" id="arriba" points="10,6,70,6,55,25,30,25" 
                                             style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" />
                                    <polygon class="parte" id="izq" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="5,13,24,32,24,57,5,80"/>

                                    <polygon class="parte" id="abajo" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="10,80,30,60,57,60,70,80"/>

                                    <polygon class="parte" id="der" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="82,2,60,35,60,50,78,85"/>
                                    
                                    <circle class="parte" id="centro" style="fill:transparent" r="11" cy="43" cx="42"></circle>

                                    </svg>
                                </div>
                                <div class="row">
                                    <div class="span6">
                                        <h3>Elija Zona</h3>
                                        <select id="zonaeditar" multiple="multiple" size="9" name="zonaeditar">
                                            <option selected="selected" value=""></option>
                                            <option value="V">V</option>
                                            <option value="M">M</option>0"></option>
                                            <option value="V">V</option>
                                            <option value="D">D</option>
                                            <option value="P">P</option>
                                            <option value="L">L</option>
                                            <option value="O">O</option>
                                            <option value="I">I</option>
                                        </select>
                                    </div>

                                    <div class="span6"> 
                                        <h3>Elija Enfermedad</h3>
                                        <select id="enfermedadeditar" multiple="multiple" size="9" name="enfermedadeditar">
                                            <option selected="selected" value=""></option>
                                            <option value="1">Cariado</option>
                                            <option value="2">Obturado almagana</option>
                                            <option value="3">Obturado resina</option>
                                            <option value="4">Exodoncia realizada</option>
                                            <option value="5">Exodoncia simple indicada</option>
                                            <option value="6">Exodoncia quirurgica ind</option>
                                            <option value="7">Sin eruocionar</option>
                                            <option value="8">Endodoncia realizada</option>
                                            <option value="9">Endo indicada</option>
                                            <option value="10">Sellante presente</option>
                                            <option value="11">Sellante indicado</option>
                                            <option value="12">Erosion o abrasion</option>
                                            <option value="13">Procedimiento realizado</option>
                                            <option value="14">Corona buen estado</option>
                                            <option value="15">Corona mal estado</option>
                                            <option value="16">Provisional buen estado</option>
                                            <option value="17">Provisional mal estado</option>
                                            <option value="18">Nucleo buen estado</option>
                                            <option value="19">Nucleo mal estado</option>
                                        </select>  
                                    </div>    
                                </div>
                                <div class="row">
                                    <div class="form-actions">
                                        <button class="btn btn-primary" type="submit">Agregar</button>
                                        <button class="btn" type="reset">Eliminar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>

        <!-----------------PESTANA 5---------------------------->
        <div class="tab-pane fade" id="diag">
            <div class="span12">
                <form class="form-horizontal" method="post" id="formDiag">
                    <fieldset>
                        <legend>Diagnosticos</legend>

                        <table class="table table-striped table-bordered table-condensed" id="tablaDiag" >
                            <thead>
                                <tr>
                                    <th>Diagnosticos</th>
                                    <th>Codigo</th>

                            </thead>
                            <tbody>
                                <tr>
                                    <td><textarea rows="3" class="input-xxlarge textareaDiagnostico" name="diagnostico"></textarea></td>
                                    <td> <input type="text" id="inputCodigoDiag" name="codigo" class="input-medium"></td>
                                </tr>    
                            </tbody>
                        </table>

                        <button class="btn" type="button" id="agregarDiag">Agregar Diagnostico</button>
                    </fieldset>        
                </form>
                <br> 
                <form method="post" id="formTrata">
                    <fieldset>
                        <legend>Tratamiento</legend>

                        <table class="table table-striped table-bordered table-condensed" id="tablaTrat" >
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Tratamiento</th>
                                    <th>Presupuesto</th>

                            </thead>
                            <tbody>
                                <tr>
                                    <td> <input type="text" name="codigoTrat" id="codTrat" class="input-medium"></td>
                                    <td><textarea rows="3" class="input-xxlarge textareaTratamiento" name="tratamiento"></textarea></td>
                                    <td> <input type="text" name="presupuestoT" id="presTrat" class="input-medium"></td>
                                </tr>    
                            </tbody>
                        </table>

                        <button class="btn" type="button" id="agregarTrat">Agregar Tratamiento</button>

                    </fieldset>   
                </form>
                <br>
                <form method="post" id="formEvol">
                    <fieldset>
                        <legend>Evolucion</legend>

                        <table class="table table-striped table-bordered table-condensed" id="tablaEvol" >
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>#Recibo Pago</th>
                                    <th>Tratamiento Ejecutado</th>
                                    <th>Codigo Tratamiento</th>

                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" name="fechaE" id="fechaE" class="input-medium fecha" data-datepicker="datepicker"></td>
                                    <td><input type="text" name="reciboE" id="reciboE" class="input-medium"></td>
                                    <td><textarea rows="3" class="input-xlarge textareaTratamiento" name="tratamientoE" id="tratamientoE"></textarea></td>
                                    <td><input type="text" name="codigoTratE" id="codigoTratE" class="input-medium"></td>
                                </tr>    
                            </tbody>
                        </table>

                        <button class="btn" type="button" id="agregarEvol">Agregar Evolucion</button>

                    </fieldset>
                </form>
                <form method="post" id="formPron">
                    <fieldset>
                        <legend>Pronostico</legend>    
                        <div class="control-group">
                            <label class="control-label">Pronostico</label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" value="Bueno" name="pronostico" class="{required:true}" >
                                    Bueno
                                </label>
                                <label class="radio inline">
                                    <input type="radio" value="Regular" name="pronostico" >
                                    Regular
                                </label>
                                <label class="radio inline">
                                    <input type="radio" value="Malo" name="pronostico" >
                                    Malo
                                </label>
                            </div>
                        </div>



                        <br> 
                        <div class="row-fluid">
                            <div class="span3">
                                <fieldset>
                                    <legend>Plan de tratamiento</legend>  
                                    <c:forEach items="${planTratamiento}" var="row" varStatus="sta">
                                        <label class="checkbox">
                                            <input type="checkbox" value="${row.idplanTratamiento}" name="plantratamiento${sta.index}"> ${row.nombre}
                                        </label>
                                    </c:forEach>

                                </fieldset> 
                            </div>
                            <div class="span3">
                                <fieldset>
                                    <legend>Remision</legend>  
                                    <c:forEach items="${remision}" var="row" varStatus="sta">
                                        <label class="checkbox">
                                            <input type="checkbox" value="${row.idremision}" name="remision${sta.index}"> ${row.remision}
                                        </label>
                                    </c:forEach>
                                </fieldset> 
                            </div>
                            <div class="span3">
                                <fieldset>
                                    <legend>Interconsulta</legend>  
                                    <c:forEach items="${interconsulta}" var="row" varStatus="sta">
                                        <label class="checkbox">
                                            <input type="checkbox" value="${row.idinterconsulta}" name="interconsulta${sta.index}" > ${row.interconsulta}
                                        </label>
                                    </c:forEach>
                                </fieldset> 
                            </div>
                        </div>

                        <div class="form-actions">
                            <button class="btn btn-primary" type="submit">Guardar Cambios</button>
                            <button class="btn" type="reset">Cancelar</button>
                        </div>
                    </fieldset>
                </form>

            </div>
        </div>
    </div>
</div>

<div class="modal hide fade" id="myModalDiente">
    <div class="modal-header">


    </div>
    <div class="modal-body">
        <div class="sample span6">
            <img id='phone' src='diente.jpeg' width='200' height='200' />
        </div>
        <div class="span6">
            <h4>Examen clinico</h4>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary" type="button">Guardar</button>
    </div>

</div>


