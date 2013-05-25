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

        <form id="DatosPersonales" class="form-horizontal" method="post">
            <fieldset>
                <legend>I. Datos Personales</legend>
                <div class="control-group">
                    <label for="input01" class="control-label">Nombres y Apellidos</label>
                    <div class="controls">
                        <input type="text" id="input01" class="input-xlarge {required:true}" name="nombre">
                    </div>
                </div>
                <div class="control-group">
                    <label for="input04" class="control-label">Direcci&oacute;n</label>
                    <div class="controls">
                        <input type="text" id="input04" name="direccion" class="input-xlarge {required:true}">
                    </div>
                </div>
                <div class="control-group">
                    <label for="input02" class="control-label">No de Identificaci&oacute;n</label>
                    <div class="controls">
                        <input type="text" id="input02" name="identificacion" class="{required:true}">
                    </div>
                </div>
                <div class="control-group">
                    <label for="input03" class="control-label">No de Afiliaci&oacute;n</label>
                    <div class="controls">
                        <input type="text" id="input03" name="afiliacion">
                    </div>
                </div>

                <div class="control-group">
                    <label for="input05" class="control-label">Tel&eacute;fono</label>
                    <div class="controls">
                        <input type="text" id="input05" name="telefono">
                    </div>
                </div>
                <div class="control-group">
                    <label for="input06" class="control-label">Departamento</label>
                    <div class="controls">
                        <select id="departamentos" name="departamentos" class="{required:true}">
                            <option></option>  
                            <c:forEach items="${departamentos.rowsByIndex}" var="row" varStatus="iter">
                                <option value="${row[0]}">${row[1]}</option>    
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
                        <input type="text" id="fecha" name="fecha" class="input-small {required:true}" data-datepicker="datepicker">
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
                            Otro
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label for="profesion" class="control-label">Profesi&oacute;n/Ocupaci&oacute;n</label>
                    <div class="controls">
                        <select id="profesion" name="profesion" class="{required:true}">
                            <option></option>  
                            <c:forEach items="${profesiones.rowsByIndex}" var="row" varStatus="iter">
                                <option value="${row[1]}">${row[0]}</option>    
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button class="btn btn-primary" type="submit">Crear paciente</button>
                    <button class="btn" type="reset">Cancelar</button>
                </div>
            </fieldset>
        </form>
    </div> <!--/span-->

<!--/nuevo-->