<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(function(){
        $("#editarDocente").validate({
            submitHandler: function(){
                $.ajax({
                    type: 'POST', 
                    url: "<%=request.getContextPath()%>/formController?action=editarDocente2",
                    data: $("#editarDocente").serialize(),
                    success: function(){
                        $("a[href='#listaDocentes']").click();
                    } //fin success
                }); //fin $.ajax    
            }
        });
    }); //fin readyFuntion
</script>

<div class="span9">

    <form id="editarDocente" class="form-horizontal" method="post">
        <fieldset>
            <legend>Editar docente</legend>
            <div class="control-group">
                <label for="input01" class="control-label">Identificaci&oacute;n</label>
                <div class="controls">
                    <input type="text" disabled="" id="docenteId" class="input-xlarge" name="docenteId" value="${docente.getRowsByIndex()[0][0]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input02" class="control-label">Nombres y Apellidos</label>
                <div class="controls">
                    <input type="text" id="input02" class="input-xlarge {required:true}" name="nombre" value="${docente.getRowsByIndex()[0][1]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input03" class="control-label">Clave</label>
                <div class="controls">
                    <input type="text" id="input03" class="input-xlarge {required:true}" name="clave" value="${docente.getRowsByIndex()[0][2]}">
                </div>
            </div>
            <div class="control-group">
                <label for="estado" class="control-label">Estado</label>
                <div class="controls">
                    <select id="estado" name="estado" class="{required:true}">
                        <option></option>  
                        <c:choose>
                            <c:when test="${docente.getRowsByIndex()[0][4]=='activo'}">
                                <option selected="selected" value="activo">activo</option>
                                <option value="inactivo">inactivo</option>    
                            </c:when>
                            <c:otherwise>
                                <option value="activo">activo</option>
                                <option selected="selected" value="inactivo">inactivo</option>    
                            </c:otherwise>
                        </c:choose>
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