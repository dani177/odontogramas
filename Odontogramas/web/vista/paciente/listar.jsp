<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <div class="span9">
            <br/>
            <h2>Listado de  Pacientes</h2>
            <c:choose>
                <c:when test="${fn:length(listaDePacientes)!= 0}">

                    <table class="table table-striped table-bordered table-condensed">
                        <thead>
                        <th>Cedula</th>    
                        <th>Paciente</th>
                        <th></th>
                        </thead>
                        <tbody>
                        <c:forEach items="${listaDePacientes}" var="row" varStatus="iter">
                            <tr>
                                <td>   
                            <c:out value="${row.idpersona}"/>
                            </td>
                            <td>   
                            <c:out value="${row.nombre}"/>
                            </td>
                            <td class="action icon16">
                                <a title="Datos personales" href="#verPaciente&${row.idpersona}" class="icon-eye-open"></a>
                                <a title="Consultas" href="#listaConsultas&${row.idpersona}" class="icon-plus"></a>
                                <a title="radiografias" href="<%=request.getContextPath()%>/subirRadiografia?${row.idpersona}" class="icon-share-alt"></a>
                            </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    No existen pacientes para este medico registrados en el sistema.
                </c:otherwise>
            </c:choose>
        </div>



