<%-- 
    Document   : ver
    Created on : 23/01/2013, 10:55:54 PM
    Author     : jubarcos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="span9">

    <form id="verDocente" class="form-horizontal" method="post">
        <fieldset>
            <legend>Detalle Docente</legend>
            <div class="control-group">
                <label for="input01" class="control-label">Identificaci&oacute;n</label>
                <div class="controls">
                    <input type="text" disabled="" id="docenteId" class="input-xlarge" name="docenteId" value="${docente.getRowsByIndex()[0][0]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input02" class="control-label">Nombres y Apellidos</label>
                <div class="controls">
                    <input type="text" disabled="" id="input02" class="input-xlarge {required:true}" name="nombre" value="${docente.getRowsByIndex()[0][1]}">
                </div>
            </div>
            <div class="control-group">
                <label for="input03" class="control-label">Clave</label>
                <div class="controls">
                    <input type="text" disabled="" id="input03" class="input-xlarge {required:true}" name="clave" value="${docente.getRowsByIndex()[0][2]}">
                </div>
            </div>
            <div class="control-group">
                <label for="estado" class="control-label">Estado</label>
                <div class="controls">
                    <select id="estado" disabled="" name="estado" class="{required:true}">
                        <option></option>  
                        <c:choose>
                            <c:when test="${docente.getRowsByIndex()[0][4]=='activo'}">
                                <option selected="selected" value="activo">Activo</option>
                                <option value="inactivo">Inactivo</option>   
                            </c:when>
                            <c:otherwise>
                                <option value="activo">Activo</option>
                                <option selected="selected" value="inactivo">Inactivo</option>    
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
            </div>
        </fieldset>
    </form>
</div> <!--/span-->

<!--/nuevo-->
