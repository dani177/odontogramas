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
                    url: "<%=request.getContextPath()%>/formController?action=guardarDatosPer",
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
                    <span class="input-xlarge uneditable-input">${paciente.getIdpersona()}</span>
                </div>
            </div>
            <div class="control-group">
                <label for="input03" class="control-label">No de Afiliacion</label>
                <div class="controls">
                    <input type="text" id="input03" name="afiliacion" value="${paciente.getNumAfiliacion()}">
                </div>
            </div>

            <div class="control-group">
                <label for="input05" class="control-label">Telefono</label>
                <div class="controls">
                    <input type="text" id="input05" name="telefono" value="${paciente.getTelefono()}">
                </div>
            </div>
            <div class="control-group">
                <label for="input06" class="control-label">Departamento</label>
                <div class="controls">
                    <select id="departamentos" name="departamentos" class="{required:true}">
                        <c:forEach items="${departamentos}" var="row" varStatus="iter">
                            <c:choose>
                                <c:when test="${row.codigo!=paciente.getMunicipiosCodigo().getDepartamentosCodigo1().getCodigo()}">
                                    <option value="${row.codigo}">${row.nombre}</option>    
                                </c:when>
                                <c:otherwise>
                                    <option selected="selected" value="${row.codigo}">${row.nombre}</option>    
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
                        <c:forEach items="${municipios}" var="row" varStatus="iter">
                            <c:choose>
                                <c:when test="${row.codigo!=paciente.getMunicipiosCodigo().getCodigo()}">
                                    <option value="${row.codigo}">${row.nombre}</option>    
                                </c:when>
                                <c:otherwise>
                                    <option selected="selected" value="${row.codigo}">${row.nombre}</option>    
                                </c:otherwise>     
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label for="fecha" class="control-label">Fecha de Nacimiento</label>
                <div class="controls">
                    <input type="text" id="fecha" name="fecha" class="input-small {rquired:true}" data-datepicker="datepicker" value="${fecha}">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Sexo</label>
                <div class="controls">
                    <c:choose>
                        <c:when test="${paciente.getSexo()=='masculino'}">
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
                        <c:when test="${paciente.getSexo()=='femenino'}">
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
                        <c:when test="${paciente.getEstadoCivil()=='soltero'}">
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
                        <c:when test="${paciente.getEstadoCivil()=='casado'}">
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
                        <c:when test="${paciente.getEstadoCivil()=='otro'}">
                            <label class="radio inline">
                                <input type="radio" value="otro" name="estadoCivil"  checked="checked">
                                otro
                            </label>
                        </c:when>
                        <c:otherwise>
                            <label class="radio inline">
                                <input type="radio" value="otro" name="estadoCivil" >
                                otro
                            </label>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
            <div class="control-group">
                <label for="profesion" class="control-label">Profesion/Ocupacion</label>
                <div class="controls">
                    <select id="profesion" name="profesion" class="{required:true}">
                        <option></option>  
                        <c:forEach items="${profesiones}" var="row" varStatus="iter">
                            <c:choose>
                                <c:when test="${row.codigo!=paciente.getProfesionesCodigo().getCodigo()}">
                                    <option value="${row.codigo}">${row.getProfesion()}</option>    
                                </c:when>
                                <c:otherwise>
                                    <option selected="selected"value="${row.codigo}">${row.getProfesion()}</option>    
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
