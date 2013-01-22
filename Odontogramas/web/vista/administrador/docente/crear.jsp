<%-- 
    Document   : crear
    Created on : 21/01/2013, 04:46:49 PM
    Author     : jubarcos
--%>
<script type="text/javascript">
    $(function(){
        $("#crearDocente").validate({
            submitHandler: function(){
                $.ajax({
                    type: 'POST', 
                    url: "<%=request.getContextPath()%>/formController?action=crearDocente",
                    data: $("#crearDocente").serialize(),
                    success: function(){
                        $("a[href='#listaDocentes']").click();
                    } //fin success
                }); //fin $.ajax    
            }
        });
    }); //fin readyFuntion
</script>

<div class="span9">

    <form id="crearDocente" class="form-horizontal" method="post">
        <fieldset>
            <legend>Nuevo docente</legend>
            <div class="control-group">
                <label for="input01" class="control-label">Identificaci&oacute;n</label>
                <div class="controls">
                    <input type="text" id="input01" class="input-xlarge {required:true}" name="docenteId">
                </div>
            </div>
            <div class="control-group">
                <label for="input02" class="control-label">Nombre</label>
                <div class="controls">
                    <input type="text" id="input02" class="input-xlarge {required:true}" name="nombre">
                </div>
            </div>
            <div class="control-group">
                <label for="input03" class="control-label">Clave</label>
                <div class="controls">
                    <input type="text" id="input03" class="input-xlarge {required:true}" name="clave">
                </div>
            </div>
            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Crear docente</button>
                <button class="btn" type="reset">Cancelar</button>
            </div>
        </fieldset>
    </form>
</div> <!--/span-->

<!--/nuevo-->