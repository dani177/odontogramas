<script type="text/javascript">
    $(function(){
        $("#editarCurso").validate({
            submitHandler: function(){
                $.ajax({
                    type: 'POST', 
                    url: "<%=request.getContextPath()%>/formController?action=editarCurso2",
                    data: $("#editarCurso").serialize(),
                    success: function(){
                        $("a[href='#listaCursos']").click();
                    } //fin success
                }); //fin $.ajax    
            }
        });
    }); //fin readyFuntion
</script>



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="span9">

    <form id="editarCurso" class="form-horizontal" method="post">
        <fieldset>
            <legend>Editar curso</legend>
            <div class="control-group">
                <label for="input01" class="control-label">Nombre</label>
                <div class="controls">
                    <input type="text" id="input01" class="input-xlarge {required:true}" name="nombre" value="${curso.getRowsByIndex()[0][1]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input02" class="control-label">C&oacute;digo</label>
                <div class="controls">
                    <input type="text" id="input02" class="input-xlarge {required:true}" name="codigo" value="${curso.getRowsByIndex()[0][2]}">
                </div>
            </div>
            <div class="control-group">
                <label for="estado" class="control-label">Estado</label>
                <div class="controls">
                    <select id="estado" name="estado" class="{required:true}">
                        <c:choose>
                            <c:when test="${curso.getRowsByIndex()[0][3]=='activo'}">
                                <option value="activo" selected="selected">Activo</option>    
                            </c:when>
                            <c:otherwise>
                                <option value="activo" selected="selected">Activo</option>    
                            </c:otherwise>    
                        </c:choose>
                        <c:choose>
                            <c:when test="${curso.getRowsByIndex()[0][3]=='inactivo'}">
                                <option value="inactivo" selected="selected">Inactivo</option>    
                            </c:when>
                            <c:otherwise>
                                <option value="inactivo" >Inactivo</option>    
                            </c:otherwise>    
                        </c:choose>


                    </select>
                </div>
            </div>
            <div class="control-group">
                <label for="input03" class="control-label">A&ntilde;o</label>
                <div class="controls">
                    <input type="text" id="input03" class="input-xlarge {required:true}" name="anio" value="${curso.getRowsByIndex()[0][4]}">
                </div>
            </div>
            <div class="control-group">
                <label for="periodo" class="control-label">Periodo</label>
                <div class="controls">
                    <select id="periodo" name="periodo" class="{required:true}">
                        <c:choose>
                            <c:when test="${curso.getRowsByIndex()[0][5]=='I'}">
                                <option value="I" selected="selected">I</option>    
                            </c:when>
                            <c:otherwise>
                                <option value="I">I</option>    
                            </c:otherwise>    
                        </c:choose>
                        <c:choose>
                            <c:when test="${curso.getRowsByIndex()[0][5]=='II'}">
                                <option value="II" selected="selected">II</option>    
                            </c:when>
                            <c:otherwise>
                                <option value="II">II</option>    
                            </c:otherwise>    
                        </c:choose>


                    </select>
                </div>
            </div>
            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Editar curso</button>
                <button class="btn" type="reset">Cancelar</button>
            </div>
        </fieldset>
    </form>
</div> <!--/span-->

<!--/nuevo-->