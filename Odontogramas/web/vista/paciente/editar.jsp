<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    $(function(){
        $('#fecha').datepicker();
        $('#departamentos').change(function()
        {
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=municipios",
                data: 'codDep='+$('#departamentos option:selected').val(),
                dataType: "json",
                success: function(data){
                    $("#municipios").html("<option></option>");
                    $.each(data['0']["municipios"], function(index, value) {
                        var b = data['0']["municipios"][index]['cod'];
                        var a = data['0']["municipios"][index]['nombre'];
                        $("#municipios").append("<option value='"+b+"'>"+a+"</option>");
                    });
                } //fin success
            }); //fin $.ajax    
        });
                
                
        $("#DatosPersonales").validate({
            submitHandler: function(){
                $.ajax({
                    type: 'POST', 
                    url: "<%=request.getContextPath()%>/formController?action=editarDatosPer",
                    data: $("#DatosPersonales").serialize(),
                    success: function(){
                        $("a[href='#listaPacientes']").click();
                    } //fin success
                }); //fin $.ajax    
            }
        });
    }); //fin readyFuntion
</script>


<!--nuevo-->

<div class="span9">

    <form id="DatosPersonales" class="form-horizontal" method="post">
        <fieldset>
            <legend>I. Datos Personales</legend>
            <div class="control-group">
                <label for="nombre" class="control-label">Nombres y Apellidos</label>
                <div class="controls">
                    <input type="text" id="input01" class="input-xlarge {required:true}" name="nombre" value="${paciente.getRowsByIndex()[0][1]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input04" class="control-label">Direcci&oacute;n</label>
                <div class="controls">
                    <input type="text" id="direccion" name="direccion" class="input-xlarge {required:true}" value="${paciente.getRowsByIndex()[0][2]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input02" class="control-label">No de Identificaci&oacute;n</label>
                <div class="controls">
                    <span class="input-xlarge uneditable-input">${paciente.getRowsByIndex()[0][0]}</span>
                </div>
            </div>
            <div class="control-group">
                <label for="input03" class="control-label">No de Afiliaci&oacute;n</label>
                <div class="controls">
                    <input type="text" id="input03" name="afiliacion" value="${paciente.getRowsByIndex()[0][3]}">
                </div>
            </div>

            <div class="control-group">
                <label for="input05" class="control-label">Tel&eacute;fono</label>
                <div class="controls">
                    <input type="text" id="input05" name="telefono" value="${paciente.getRowsByIndex()[0][4]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input06" class="control-label">Departamento</label>
                <div class="controls">
                    <select id="departamentos" name="departamentos" class="{required:true}">
                        <c:forEach items="${departamentos.rowsByIndex}" var="row" varStatus="iter">
                            <c:choose>
                                <c:when test="${row[0]!=departamento.getRowsByIndex()[0][12]}">
                                    <option value="${row[0]}">${row[1]}</option>    
                                </c:when>
                                <c:otherwise>
                                    <option selected="selected" value="${row[0]}">${row[1]}</option>    
                                </c:otherwise>     
                            </c:choose>
            
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label for="input06" class="control-label">Ciudad/Municipio</label>
                <div class="controls">
                    <select id="municipios" name="municipio" class="{required:true}">
                        <c:forEach items="${municipios.rowsByIndex}" var="row" varStatus="iter">
                            <c:choose>
                                <c:when test="${row[0]!=paciente.getRowsByIndex()[0][8]}">
                                    <option value="${row[0]}">${row[1]}</option>    
                                </c:when>
                                <c:otherwise>
                                    <option selected="selected" value="${row[0]}">${row[1]}</option>    
                                </c:otherwise>     
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label for="fecha" class="control-label">Fecha de Nacimiento</label>
                <div class="controls">
                    <input type="text" id="fecha" name="fecha" class="input-small {required:true}" data-datepicker="datepicker" value="${fecha}">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Sexo</label>
                <div class="controls">
                    <c:choose>
                        <c:when test="${paciente.getRowsByIndex()[0][5]=='masculino'}">
                            <label class="radio inline">
                                <input type="radio" value="masculino" name="sexo" class="{required:true}" checked="checked" >
                                Hombre
                            </label>
                        </c:when>
                        <c:otherwise>
                            <label class="radio inline">
                                <input type="radio" value="masculino" name="sexo" class="{required:true}" checked="checked" >
                                Hombre
                            </label>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${paciente.getRowsByIndex()[0][5]=='femenino'}">
                            <label class="radio inline">
                                <input type="radio" value="femenino" name="sexo" checked="checked">
                                Mujer
                            </label>
                        </c:when>
                        <c:otherwise>
                            <label class="radio inline">
                                <input type="radio" value="femenino" name="sexo" >
                                Mujer
                            </label>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Estado Civil</label>
                <div class="controls">
                    <c:choose>
                        <c:when test="${paciente.getRowsByIndex()[0][6]=='soltero'}">
                            <label class="radio inline">
                                <input type="radio" value="soltero" name="estadoCivil" class="{required:true}" checked="checked" >
                                Soltero
                            </label>
                        </c:when>
                        <c:otherwise>
                            <label class="radio inline">
                                <input type="radio" value="soltero" name="estadoCivil" class="{required:true}" >
                                Soltero
                            </label>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${paciente.getRowsByIndex()[0][6]=='casado'}">
                            <label class="radio inline">
                                <input type="radio" value="casado" name="estadoCivil" checked="checked" >
                                Casado
                            </label>
                        </c:when>
                        <c:otherwise>
                            <label class="radio inline">
                                <input type="radio" value="casado" name="estadoCivil" >
                                Casado
                            </label>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${paciente.getRowsByIndex()[0][6]=='otro'}">
                            <label class="radio inline">
                                <input type="radio" value="otro" name="estadoCivil"  checked="checked">
                                Otro
                            </label>
                        </c:when>
                        <c:otherwise>
                            <label class="radio inline">
                                <input type="radio" value="otro" name="estadoCivil" >
                                Otro
                            </label>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
            <div class="control-group">
                <label for="profesion" class="control-label">Profesi&oacute;n/Ocupaci&oacute;n</label>
                <div class="controls">
                    <select id="profesion" name="profesion" class="{required:true}">
                        <option></option>  
                        <c:forEach items="${profesiones.rowsByIndex}" var="row" varStatus="iter">
                            <c:choose>
                                <c:when test="${row[1]!=paciente.getRowsByIndex()[0][9]}">
                                    <option value="${row[1]}">${row[0]}</option>    
                                </c:when>
                                <c:otherwise>
                                    <option selected="selected" value="${row[1]}">${row[0]}</option>    
                                </c:otherwise>     
                            </c:choose>
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

<!--/nuevo-->
