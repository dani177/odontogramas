<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    $(function(){
        
        
        
        
        
        $('.fecha').datepicker();        
        $("#agregarDiag").click(function(){
            $("#tablaDiag").append("<tr>"
                +"<td><textarea rows='3' class='input-xxlarge textareaDiagnostico'></textarea></td>"
                +"<td> <input type='text' name='codigo' class='input-medium'></td>"
                +"</tr>  ");
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
                           // $("a[href='#listaPacientes']").click();
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
        <li ><a href="#diag" data-toggle="tab">III. Diagnostico Y Tratamiento </a></li>
    </ul>




    <!-------------PESTANA 1--------------------------------------------->
    <div id="myTabContent" class="tab-content">
        <!------------------PESTANA 2------------------------------------------>
        <div class="tab-pane fade in active " id="profile">
            <!--nuevo2-->

            <div class="span12">
                <form class="form-horizontal" id="datos2">
                    <fieldset>
                        <legend>II. Datos Personales</legend>
                        <div class="control-group">
                            <label for="textarea02" class="control-label">Motivo de la consulta</label>
                            <div class="controls">
                                <textarea rows="3" id="textarea02" class="input-xxlarge"></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="textarea03" class="control-label">Historia de la enfermedad actual</label>
                            <div class="controls">
                                <textarea rows="3" id="textarea03" class="input-xxlarge"></textarea>
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
                                        <td> <input type="radio" value="no sabe" name="${row.nombre}" ></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>


                        <div class="control-group">
                            <label for="textareaObs" class="control-label">Observaciones</label>
                            <div class="controls">
                                <textarea rows="3" id="textareaObs" class="input-xxlarge"></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="Otros" class="control-label">Otros</label>
                            <div class="controls">
                                <textarea rows="3" id="Otros" class="input-xxlarge"></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="ultima" class="control-label">Ultima Visita al odontologo</label>
                            <div class="controls">
                                <input type="text" id="ultima" class="input-medium" data-datepicker="datepicker">
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="motivo" class="control-label">Motivo</label>
                            <div class="controls">
                                <textarea rows="3" id="motivo" class="input-xxlarge"></textarea>
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
                <form class="form-horizontal">
                    <fieldset>
                        <legend>III. Examen Fisico Estomatologico</legend>
                        <div class="control-group">
                            <label for="temperatura" class="control-label">Temperatura</label>
                            <div class="controls">
                                <input id="temperatura"  type="text" >
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="pulso" class="control-label">Pulso</label>
                            <div class="controls">
                                <input id="pulso"  type="text" >
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="tension" class="control-label">Tension A.</label>
                            <div class="controls">
                                <input id="tension"  type="text" >
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Higiene Oral</label>
                            <div class="controls">
                                <select id="seda">
                                    <option>Buena</option>
                                    <option>Regular</option>
                                    <option>Mala</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Uso de seda dental</label>
                            <div class="controls">
                                <select id="seda">
                                    <option>Si</option>
                                    <option>No</option>
                                    <option>Aveces</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Cepillo dental:Uso</label>
                            <div class="controls">
                                <select id="seda">
                                    <option>Si</option>
                                    <option>No</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Cuantas veces al dia</label>
                            <div class="controls">
                                <select id="veces">
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
                                <select id="enjuages">
                                    <option>Si</option>
                                    <option>No</option>
                                    <option>Aveces</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"> Uso de Enjuages Bucales con fluor</label>
                            <div class="controls">
                                <select id="enjuages">
                                    <option>Si</option>
                                    <option>No</option>
                                    <option>Aveces</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Habitos y vicios</label>
                            <div class="controls">
                                <select id="habitosYvicios">
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
        <div class="tab-pane fade" id="diag">
            <div class="span12">
                <form class="form-horizontal">
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
                                    <td><textarea rows="3" class="input-xxlarge textareaDiagnostico"></textarea></td>
                                    <td> <input type="text" id="inputCodigoDiag" name="codigo" class="input-medium"></td>
                                </tr>    
                            </tbody>
                        </table>

                        <button class="btn" type="button" id="agregarDiag">Agregar Diagnostico</button>

                    </fieldset>        
                    <br> 
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
                            <input type="checkbox" value="Cirujia" name="tratamiento6"> Cirujia
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
                    <br>
                    <fieldset>
                        <legend>Tratamiento</legend>

                        <table class="table table-striped table-bordered table-condensed" id="tablaTrat" >
                            <thead>
                                <tr>
                                    <th>Tratamiento</th>
                                    <th>Presupuesto</th>

                            </thead>
                            <tbody>
                                <tr>
                                    <td><textarea rows="3" class="input-xxlarge textareaTratamiento"></textarea></td>
                                    <td> <input type="text" name="codigo" class="input-medium"></td>
                                </tr>    
                            </tbody>
                        </table>

                        <button class="btn" type="button" id="agregarTrat">Agregar Tratamiento</button>

                    </fieldset>   
                    <br>
                    <fieldset>
                        <legend>Evolucion</legend>

                        <table class="table table-striped table-bordered table-condensed" id="tablaTrat" >
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>#Recibo Pago</th>
                                    <th>Tratamiento Ejecutado</th>

                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" name="fecha" class="input-medium fecha" data-datepicker="datepicker"></td>
                                    <td><input type="text" name="recibo" class="input-medium"></td>
                                    <td><textarea rows="3" class="input-xxlarge textareaTratamiento"></textarea></td>
                                </tr>    
                            </tbody>
                        </table>

                        <button class="btn" type="button" id="agregarEvol">Agregar Evolucion</button>

                    </fieldset>

                    <div class="form-actions">
                        <button class="btn btn-primary" type="submit">Guardar cambios</button>
                        <button class="btn" type="reset">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>