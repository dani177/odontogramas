<%-- 
    Document   : crear
    Created on : 21/01/2013, 04:46:49 PM
    Author     : jubarcos
--%>
<script type="text/javascript">
    $(function(){
        $("#crearCurso").validate({
            submitHandler: function(){
                $.ajax({
                    type: 'POST', 
                    url: "<%=request.getContextPath()%>/formController?action=crearCurso",
                    data: $("#crearCurso").serialize(),
                    success: function(){
                        $("a[href='#listaCursos']").click();
                    } //fin success
                }); //fin $.ajax    
            }
        });
    }); //fin readyFuntion
</script>

<div class="span9">

    <form id="crearCurso" class="form-horizontal" method="post">
        <fieldset>
            <legend>Nuevo curso</legend>
            <div class="control-group">
                <label for="input01" class="control-label">Nombre</label>
                <div class="controls">
                    <input type="text" id="input01" class="input-xlarge {required:true}" name="nombre">
                </div>
            </div>
            <div class="control-group">
                <label for="input02" class="control-label">C&oacute;digo</label>
                <div class="controls">
                    <input type="text" id="input02" class="input-xlarge {required:true}" name="codigo">
                </div>
            </div>
            <div class="control-group">
                <label for="estado" class="control-label">Estado</label>
                <div class="controls">
                    <select id="estado" name="estado" class="{required:true}">
                        <option></option>  
                        <option value="activo">Activo</option>    
                        <option value="inactivo">Inactivo</option>    
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label for="input03" class="control-label">A&ntilde;o</label>
                <div class="controls">
                    <input type="text" id="input03" class="input-xlarge {required:true}" name="anio">
                </div>
            </div>
            <div class="control-group">
                <label for="periodo" class="control-label">Periodo</label>
                <div class="controls">
                    <select id="periodo" name="periodo" class="{required:true}">
                        <option></option>  
                        <option value="I">I</option>    
                        <option value="II">II</option>    
                    </select>
                </div>
            </div>
            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Crear curso</button>
                <button class="btn" type="reset">Cancelar</button>
            </div>
        </fieldset>
    </form>
</div> <!--/span-->

<!--/nuevo-->