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
            
            
            
            
            
        }); //fin function
</script>


<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div>
    <ul id="tab" class="nav nav-tabs">
        <li class="active"><a href="#home2" data-toggle="tab">I. Datos Personales</a></li>
        <li ><a href="#profile" data-toggle="tab">II. Datos Basicos</a></li>
        <li ><a href="#otro" data-toggle="tab">III. Examen Fisico Estomatologico</a></li>
        <li ><a href="#diag" data-toggle="tab">IV. Diagnostico Y Tratamiento </a></li>
    </ul>




    <!-------------PESTANA 1--------------------------------------------->
    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active" id="home2">

            <!--nuevo-->

            <div class="span12">

                <form id="DatosPersonales" class="form-horizontal">
                    <fieldset>
                        <legend>I. Datos Personales</legend>
                        <div class="control-group">
                            <label for="input01" class="control-label">Nombre</label>
                            <div class="controls">
                                <input type="text" id="input01" class="input-xlarge {required:true}" name="nombre" value="${paciente.getNombre()}">
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="input04" class="control-label">Direccion</label>
                            <div class="controls">
                                <input type="text" id="input04" name="direccion" class="input-xlarge {required:true}" value="${paciente.getDireccion()}">
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="input02" class="control-label">No de Identificacion</label>
                            <div class="controls">
                                <input type="text" id="input02" name="identificacion" class="{required:true}" value="${paciente.getIdpersona()}">
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="input03" class="control-label">No de Afiliacion</label>
                            <div class="controls">
                                <input type="text" id="input03" name="afiliacion" class="{required:true}">
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="input05" class="control-label">Telefono</label>
                            <div class="controls">
                                <input type="text" id="input05" name="telefono" class="{required:true}">
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="input06" class="control-label">Departamento</label>
                            <div class="controls">
                                <select id="departamentos" name="departamentos" class="{required:true}">
                                    <option></option>  
                                    <c:forEach items="${departamentos}" var="row" varStatus="iter">
                                        <option value="${row.codigo}">${row.nombre}</option>    
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="input06" class="control-label">Ciudad/Municipio</label>
                            <div class="controls">
                                <select id="municipios" name="municipio" class="{required:true}">
                                    <option></option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="fecha" class="control-label">Fecha de Nacimiento</label>
                            <div class="controls">
                                <input type="text"  name="fecha" class="input-small {required:true} fecha" data-datepicker="datepicker">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Sexo</label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" value="masculino" name="sexo" class="{required:true}" >
                                    Hombre
                                </label>
                                <label class="radio inline">
                                    <input type="radio" value="femenino" name="sexo" >
                                    Mujer
                                </label>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Estado Civil</label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" value="soltero" name="estadoCivil" class="{required:true}" >
                                    Soltero
                                </label>

                                <label class="radio inline">
                                    <input type="radio" value="casado" name="estadoCivil" >
                                    Casado
                                </label>

                                <label class="radio inline">
                                    <input type="radio" value="otro" name="estadoCivil" >
                                    otro
                                </label>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="profesion" class="control-label">Profesion/Ocupacion</label>
                            <div class="controls">
                                <select id="profesion" name="profesion" class="{required:true}">
                                    <option></option>  
                                    <c:forEach items="${profesiones}" var="row" varStatus="iter">
                                        <option value="${row.codigo}">${row.profesion}</option>    
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button class="btn btn-primary" id="personales" type="submit">Guardar cambios</button>
                            <button class="btn" type="reset">Cancelar</button>
                        </div>
                    </fieldset>
                </form>
            </div> <!--/span-->

            <!--/nuevo-->

        </div>


        <!------------------PESTANA 2------------------------------------------>
        <div class="tab-pane fade " id="profile">
            <!--nuevo2-->

            <div class="span12">
                <form class="form-horizontal">
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
                                    <th>Datos Basicos</th>
                                    <th>Si</th>
                                    <th>No</th>
                                    <th>No Sabe</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Tratamiento Medico</td>
                                    <td> <input type="radio" value="option1" name="Tratamiento" ></td>
                                    <td> <input type="radio" value="option1" name="Tratamiento" ></td>
                                    <td> <input type="radio" value="option1" name="Tratamiento" ></td>

                                    <td>Diabetes</td>
                                    <td> <input type="radio" value="option1" name="Diabetes" ></td>
                                    <td> <input type="radio" value="option1" name="Diabetes" ></td>
                                    <td> <input type="radio" value="option1" name="Diabetes" ></td>
                                </tr>
                                <tr>
                                    <td>Ingestion Medicamentos</td>
                                    <td> <input type="radio" value="option1" name="Ingestion" ></td>
                                    <td> <input type="radio" value="option1" name="Ingestion" ></td>
                                    <td> <input type="radio" value="option1" name="Ingestion" ></td>

                                    <td>Fiebre Reumatica</td>
                                    <td> <input type="radio" value="option1" name="Fiebre" ></td>
                                    <td> <input type="radio" value="option1" name="Fiebre" ></td>
                                    <td> <input type="radio" value="option1" name="Fiebre" ></td>
                                </tr>
                                <tr>
                                    <td>Reacciones Alergicas</td>
                                    <td> <input type="radio" value="option1" name="Reacciones" ></td>
                                    <td> <input type="radio" value="option1" name="Reacciones" ></td>
                                    <td> <input type="radio" value="option1" name="Reacciones" ></td>

                                    <td>Hepatitia</td>
                                    <td> <input type="radio" value="option1" name="Hepatitia" ></td>
                                    <td> <input type="radio" value="option1" name="Hepatitia" ></td>
                                    <td> <input type="radio" value="option1" name="Hepatitia" ></td>
                                </tr>
                                <tr>
                                    <td>Anestesia </td>
                                    <td> <input type="radio" value="option1" name="Anestesia" ></td>
                                    <td> <input type="radio" value="option1" name="Anestesia" ></td>
                                    <td> <input type="radio" value="option1" name="Anestesia" ></td>

                                    <td>Hipertension</td>
                                    <td> <input type="radio" value="option1" name="Hipertension" ></td>
                                    <td> <input type="radio" value="option1" name="Hipertension" ></td>
                                    <td> <input type="radio" value="option1" name="Hipertension" ></td>
                                </tr>
                                <tr>
                                    <td>Antibioticos </td>
                                    <td> <input type="radio" value="option1" name="Antibioticos" ></td>
                                    <td> <input type="radio" value="option1" name="Antibioticos" ></td>
                                    <td> <input type="radio" value="option1" name="Antibioticos" ></td>

                                    <td>Embarazo</td>
                                    <td> <input type="radio" value="option1" name="Embarazo" ></td>
                                    <td> <input type="radio" value="option1" name="Embarazo" ></td>
                                    <td> <input type="radio" value="option1" name="Embarazo" ></td>
                                </tr>
                            <td>Hemorragias</td>
                            <td> <input type="radio" value="option1" name="Hemorragias" ></td>
                            <td> <input type="radio" value="option1" name="Hemorragias" ></td>
                            <td> <input type="radio" value="option1" name="Hemorragias" ></td>

                            <td>Enfermedades Renales</td>
                            <td> <input type="radio" value="option1" name="Renales" ></td>
                            <td> <input type="radio" value="option1" name="Renales" ></td>
                            <td> <input type="radio" value="option1" name="Renales" ></td>
                            </tr>
                            <td>Irradiaciones</td>
                            <td> <input type="radio" value="option1" name="Irradiaciones" ></td>
                            <td> <input type="radio" value="option1" name="Irradiaciones" ></td>
                            <td> <input type="radio" value="option1" name="Irradiaciones" ></td>

                            <td>Enfermedades Gastroinstestinales</td>
                            <td> <input type="radio" value="option1" name="Gastroinstestinales" ></td>
                            <td> <input type="radio" value="option1" name="Gastroinstestinales" ></td>
                            <td> <input type="radio" value="option1" name="Gastroinstestinales" ></td>
                            </tr>
                            <td>Sinusitis</td>
                            <td> <input type="radio" value="option1" name="Sinusitis" ></td>
                            <td> <input type="radio" value="option1" name="Sinusitis" ></td>
                            <td> <input type="radio" value="option1" name="Sinusitis" ></td>

                            <td>Organos de los Sentidos</td>
                            <td> <input type="radio" value="option1" name="Sentidos" ></td>
                            <td> <input type="radio" value="option1" name="Sentidos" ></td>
                            <td> <input type="radio" value="option1" name="Sentidos" ></td>
                            </tr>

                            <td>Enfermedades Respiratorias</td>
                            <td> <input type="radio" value="option1" name="Respiratorias" ></td>
                            <td> <input type="radio" value="option1" name="Respiratorias" ></td>
                            <td> <input type="radio" value="option1" name="Respiratorias" ></td>

                            <td>Enfermedades Infectocontagiosas</td>
                            <td> <input type="radio" value="option1" name="Infectocontagiosas" ></td>
                            <td> <input type="radio" value="option1" name="Infectocontagiosas" ></td>
                            <td> <input type="radio" value="option1" name="Infectocontagiosas" ></td>
                            </tr>
                            <td>Cardiopatias</td>
                            <td> <input type="radio" value="option1" name="Cardiopatias" ></td>
                            <td> <input type="radio" value="option1" name="Cardiopatias" ></td>
                            <td> <input type="radio" value="option1" name="Cardiopatias" ></td>
                            <td colspan="4"></td>
                            </tr>
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

