<%-- 
    Document   : crear
    Created on : 21/01/2013, 04:46:49 PM
    Author     : jubarcos
--%>
<script type="text/javascript">
    $(function(){
        $("#crearDocente").validate({
            rules: {
                docenteId: {
                    required: true,
                    remote: {
                        url: "<%=request.getContextPath()%>/formController?action=validaIdDocente",
                        data: {
                            docenteId: function() {
                                return $("#docenteId").val();
                            }
                    
                        }
                    }
                }
            },
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
            <legend>Nuevo Docente</legend>
            <div class="control-group">
                <label for="input01" class="control-label">Identificaci&oacute;n</label>
                <div class="controls">
                    <input type="text" id="docenteId" class="input-xlarge" name="docenteId">
                </div>
            </div>
            <div class="control-group">
                <label for="input02" class="control-label">Nombres y Apellidos</label>
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
            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Crear docente</button>
                <button class="btn" type="reset">Cancelar</button>
            </div>
        </fieldset>
    </form>
</div> <!--/span-->

<!--/nuevo-->