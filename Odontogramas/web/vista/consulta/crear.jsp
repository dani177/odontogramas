<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    $(function(){
   
        $('.ultima').datepicker();        
        $('.fecha').datepicker();        
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

                        <table>
                            <tbody><tr>
                                    <td><table border="0">
                                            <!-- Primera fila -->
                                            <tbody><tr>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d18.gif" name="18" id="d18"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d17.gif" name="17" id="d17"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d16.gif" name="16" id="d16"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d15.gif" name="15" id="d15"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d14.gif" name="14" id="d14"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d13.gif" name="13" id="d13"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d12.gif" name="12" id="d12"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d11.gif" name="11" id="d11"></td>
                                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d21.gif" name="21" id="d21"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d22.gif" name="22" id="d22"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d23.gif" name="23" id="d23"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d24.gif" name="24" id="d24"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d25.gif" name="25" id="d25"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d26.gif" name="26" id="d26"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d27.gif" name="27" id="d27"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d28.gif" name="28" id="d28"></td>
                                                </tr>
                                                <!-- Segunda fila -->
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d55.gif" name="55" id="d55"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d54.gif" name="54" id="d54"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d53.gif" name="53" id="d53"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d52.gif" name="52" id="d52"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d51.gif" name="51" id="d51"></td>
                                                    <td><b><b><b><b><b><b></b></b></b></b></b></b></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d61.gif" name="61" id="d61"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d62.gif" name="62" id="d62"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d63.gif" name="63" id="d63"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d64.gif" name="64" id="d64"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d65.gif" name="65" id="d65"></td>
                                                    <td><b></b></td>
                                                    <td><b></b></td>
                                                    <td><b></b></td>
                                                </tr>
                                                <!-- Tercera fila -->
                                                <tr>
                                                    <td><b></b></td>
                                                    <td><b></b></td>
                                                    <td><b></b></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d85.gif" name="85" id="d85"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d84.gif" name="84" id="d84"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d83.gif" name="83" id="d83"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d82.gif" name="82" id="d82"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d81.gif" name="81" id="d81"></td>
                                                    <td></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d71.gif" name="71" id="d71"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d72.gif" name="72" id="d72"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d73.gif" name="73" id="d73"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d74.gif" name="74" id="d74"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d75.gif" name="75" id="d75"></td>
                                                    <td><b></b></td>
                                                    <td><b></b></td>
                                                    <td><b></b></td>
                                                </tr>
                                                <!-- Cuarta fila -->
                                                <tr>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d48.gif" name="48" id="d48"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d47.gif" name="47" id="d47"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d46.gif" name="46" id="d46"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d45.gif" name="45" id="d45"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d44.gif" name="44" id="d44"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d43.gif" name="43" id="d432"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d42.gif" name="42" id="d42"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d41.gif" name="41" id="d41"></td>
                                                    <td></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d31.gif" name="31" id="d31"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d32.gif" name="32" id="d32"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d33.gif" name="33" id="d33"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d34.gif" name="34" id="d34"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d35.gif" name="35" id="d35"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d36.gif" name="36" id="d36"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d37.gif" name="37" id="d37"></td>
                                                    <td><img alt="" style="cursor:pointer" src="imagenes/d38.gif" name="38" id="d38"></td>
                                                </tr>
                                            </tbody></table>
                                        <div>
                                            <table border="0">
                                                <tbody><tr style="height: 36px;">

                                                        <td style="height: 36px;">
                                                            <h2>
                                                                <p id="estadodiente">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>
                                                            </h2>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td><table border="0">
                                                                <tbody><tr>
                                                                        <td><img alt="" src="imagenes/zonas.gif"></td>
                                                                        <td><table border="0">
                                                                                <tbody><tr>
                                                                                        <td>Elija Zona</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td><table border="0">
                                                                                                <tbody><tr>
                                                                                                        <td><select id="zonaeditar" multiple="multiple" size="5" name="zonaeditar">
                                                                                                                <option selected="selected" value="V">V</option>
                                                                                                                <option value="M">M</option>
                                                                                                                <option value="D">D</option>
                                                                                                                <option value="P">P</option>
                                                                                                                <option value="L">L</option>
                                                                                                                <option value="O">O</option>
                                                                                                                <option value="I">I</option>
                                                                                                            </select>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </tbody></table></td>
                                                                                    </tr>
                                                                                </tbody></table></td>
                                                                        <td><table border="0">
                                                                                <tbody><tr>
                                                                                        <td>Convenciones</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td><select id="enfermedadeditar" multiple="multiple" name="enfermedadeditar">
                                                                                                <option selected="selected" value="1">Cariado</option>
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
                                                                                        </td>
                                                                                        <td><input type="button" value="Agregar" id="agregar">
                                                                                            <input type="button" value="Eliminar" id="eliminar"></td>
                                                                                        <td>&nbsp;</td>
                                                                                    </tr>
                                                                                </tbody></table></td>
                                                                    </tr>
                                                                </tbody></table></td>
                                                    </tr>
                                                </tbody></table>
                                        </div></td>
                                    <td>
                                    </td>
                                </tr>
                            </tbody></table>


                        <div class="form-actions">
                            <button class="btn btn-primary" type="submit">Guardar cambios</button>
                            <button class="btn" type="reset">Cancelar</button>
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
                
                    <fieldset>
                        <legend>Pronostico</legend>    
                        <div class="control-group">
                            <label class="control-label">Pronostico</label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" value="option1" name="pronostico" >
                                    Bueno
                                </label>
                                <label class="radio inline">
                                    <input type="radio" value="option2" name="pronostico" >
                                    Regular
                                </label>
                                <label class="radio inline">
                                    <input type="radio" value="option2" name="pronostico" >
                                    Malo
                                </label>
                            </div>
                        </div>

                    </fieldset>

                    <br> 

                    <div class="span3">
                        <fieldset>
                            <legend>Plan de tratamiento</legend>  
                            <label class="checkbox">
                                <input type="checkbox" value="Semiologia" name="tratamiento1"> Semiologia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Promocion y Prevencion" name="tratamiento2"> Promocion y Prevencion
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Operatoria" name="tratamiento3"> Operatoria
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Endodoncia" name="tratamiento4"> Endodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Periodoncia" name="tratamiento5"> Periodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Cirujia" name="tratamiento6"> Cirugia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Odontopedriatia" name="tratamiento7"> Odontopedriatia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Rehabilitacion" name="tratamiento8"> Rehabilitacion
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Ortodoncia" name="tratamiento9"> Ortodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Otros" name="tratamiento10"> Otros
                            </label>    
                        </fieldset> 
                    </div>
                    <div class="span3">
                        <fieldset>
                            <legend>Remision</legend>  
                            <label class="checkbox">
                                <input type="checkbox" value="Semiologia" name="tratamiento1"> Semiologia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Promocion y Prevencion" name="tratamiento2"> Promocion y Prevencion
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Operatoria" name="tratamiento3"> Operatoria
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Endodoncia" name="tratamiento4"> Endodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Periodoncia" name="tratamiento5"> Periodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Cirujia" name="tratamiento6"> Cirugia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Odontopedriatia" name="tratamiento7"> Odontopedriatia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Rehabilitacion" name="tratamiento8"> Rehabilitacion
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Ortodoncia" name="tratamiento9"> Ortodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Otros" name="tratamiento10"> Otros
                            </label>    
                        </fieldset> 
                    </div>
                    <div class="span3">
                        <fieldset>
                            <legend>Interconsulta</legend>  
                            <label class="checkbox">
                                <input type="checkbox" value="Semiologia" name="tratamiento1"> Semiologia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Promocion y Prevencion" name="tratamiento2"> Promocion y Prevencion
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Operatoria" name="tratamiento3"> Operatoria
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Endodoncia" name="tratamiento4"> Endodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Periodoncia" name="tratamiento5"> Periodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Cirujia" name="tratamiento6"> Cirugia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Odontopedriatia" name="tratamiento7"> Odontopedriatia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Rehabilitacion" name="tratamiento8"> Rehabilitacion
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Ortodoncia" name="tratamiento9"> Ortodoncia
                            </label>
                            <label class="checkbox">
                                <input type="checkbox" value="Otros" name="tratamiento10"> Otros
                            </label>    
                        </fieldset> 
                    </div>

                    <br>

                    <br>
                    
            </div>
        </div>
    </div>
</div>