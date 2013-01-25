<%-- 
    Document   : ver
    Created on : 23/01/2013, 10:55:54 PM
    Author     : jubarcos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(function(){
        $("#editarMedico").validate({
            submitHandler: function(){
                $.ajax({
                    type: 'POST', 
                    url: "<%=request.getContextPath()%>/formController?action=editarMedico2",
                    data: $("#editarMedico").serialize(),
                    success: function(){
                        $("a[href='#listaMedicos']").click();
                    } //fin success
                }); //fin $.ajax    
            }
        });
    }); //fin readyFuntion
</script>
<div class="span9">

    <form id="editarMedico" class="form-horizontal" method="post">
        <fieldset>
            <legend>Detalle medico</legend>
            <div class="control-group">
                <label for="input01" class="control-label">Identificaci&oacute;n</label>
                <div class="controls">
                    <input type="text" disabled="" id="medicoId" class="input-xlarge" name="medicoId" value="${medico.getRowsByIndex()[0][0]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input02" class="control-label">Nombre</label>
                <div class="controls">
                    <input type="text" id="input02" class="input-xlarge {required:true}" name="nombre" value="${medico.getRowsByIndex()[0][1]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input03" class="control-label">Clave</label>
                <div class="controls">
                    <input type="text"  id="input03" class="input-xlarge {required:true}" name="clave" value="${medico.getRowsByIndex()[0][2]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input04" class="control-label">Direcci&oacute;n</label>
                <div class="controls">
                    <input type="text"  id="input04" class="input-xlarge {required:true}" name="direccion" value="${medico.getRowsByIndex()[0][3]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input05" class="control-label">Telefono</label>
                <div class="controls">
                    <input type="text"  id="input05" class="input-xlarge {required:true}" name="telefono" value="${medico.getRowsByIndex()[0][4]}">
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
