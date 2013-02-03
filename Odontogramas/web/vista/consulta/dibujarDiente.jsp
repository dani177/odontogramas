<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
    <c:when test="${diente.getRowsByIndex()[0][0] > 20 && diente.getRowsByIndex()[0][0] < 29}">
        <script type="text/javascript">
            $(function(){
                $(".parte").click(function(ev){
                    //primer cuadrante
                    var parte = $(this).attr("id");
                    if(parte=="oclusal1"){
                    
                        if($("#oclusal").attr("selected")){
                            $("#oclusal").attr("selected",false);    
                        }else{
                            $("#oclusal").attr("selected",true);    
                        }
                    
                    }else{
                        if(parte=="vestibular1"){
                        
                            if($("#vestibular").attr("selected")){
                                $("#vestibular").attr("selected",false);    
                            }else{
                                $("#vestibular").attr("selected",true);
                            }
                        
                        }else{
                            if(parte=="mesial1"){
                            
                                if($("#mesial").attr("selected")){
                                    $("#mesial").attr("selected",false);    
                                }else{
                                    $("#mesial").attr("selected",true);
                                }
                            
                            }else{
                                if(parte=="distal1"){
                                
                                    if($("#distal").attr("selected")){
                                        $("#distal").attr("selected",false);
                                    }else{
                                        $("#distal").attr("selected",true);    
                                    }
                                
                                }else{
                                    if(parte=="palatinaLingual1"){
                                    
                                        if($("#palatinaLingual").attr("selected")){
                                            $("#palatinaLingual").attr("selected",false);    
                                        }else{
                                            $("#palatinaLingual").attr("selected",true);
                                        }
                                    
                                    }
                                }   
                            }
                        }   
                    }
            
                })
            });
        </script>
        <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
             width="150px" height="100px" viewBox="0 0 150 100" enable-background="new 0 0 150 100" xml:space="preserve">
            <g id="XMLID_2_">
                <g>
                    <path d="M118,43c0,4.67,0,9.33,0,14c-4.9,18.44-17.17,29.49-35,35c-5,0-10,0-15,0c-18.73-4.94-30.92-16.41-36-35
                          c0-4.67,0-9.33,0-14c5.2-18.47,17.2-30.13,36-35c4.67,0,9.33,0,14,0C100.73,12.94,112.92,24.41,118,43z M101,75
                          c14.82-6.62,14.86-37.01,4-48c-7.26,2.74-10.65,9.35-15,15c2.51,5.07,2.51,12.92,0,18C93.59,65.07,98.14,69.19,101,75z M86,37
                          c5.04-4.62,10.56-8.77,13-16c-11.72-10.71-42.71-10.92-50,4c6.23,3.1,9.13,9.54,16,12C70.02,32.28,80.39,34.24,86,37z M98,80
                          c-3.25-6.42-6.83-12.5-13-16c-3.82,6.1-16.51,4.12-22,1c-2.65,6.01-9.45,7.89-11,15C63.25,88.8,86.75,88.8,98,80z M62,52
                          c1,15.79,26.09,14.28,25-2c-0.48-7.13-5.34-12.96-16-10C64.65,41.76,61.53,44.65,62,52z M60,60c-5-4.42-2.68-14.94,0-20
                          c-6.38-2.95-9.23-9.44-16-12c-9.38,11.15-9.71,39.32,4,46C52.72,70.05,56.85,65.51,60,60z"/>

                    <!--cuadrante 1-->
                    <!--cara mesial-->
                    <c:choose>
                        <c:when test="${caraM.getRowCount()== 0}">
                            <path class="parte" id="mesial1" fill="#FFFFFF" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                  C94.35,36.35,97.74,29.74,105,27z"/>        
                        </c:when>
                        <c:when test="${caraM.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="mesial1" fill="#999999" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="mesial1" fill="#468847" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="mesial1" fill="#F89406" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="mesial1" fill="#B94A48" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="mesial1" fill="#3A87AD" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="mesial1" fill="#333333" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="mesial1" fill="#330066" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="mesial1" fill="#330000" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="mesial1" fill="#FFFF00" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="mesial1" fill="#ff0000" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                  C94.35,36.35,97.74,29.74,105,27z"/>
                        </c:otherwise>    
                    </c:choose>
                    <!--cara vestibular-->
                    <c:choose>
                        <c:when test="${caraV.getRowCount()== 0}">
                            <path class="parte" id="vestibular1" fill="#FFFFFF" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                  C56.29,10.08,87.28,10.29,99,21z"/>        
                        </c:when>
                        <c:when test="${caraV.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="vestibular1" fill="#999999" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="vestibular1" fill="#468847" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="vestibular1" fill="#F89406" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="vestibular1" fill="#B94A48" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="vestibular1" fill="#3A87AD" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="vestibular1" fill="#333333" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="vestibular1" fill="#330066" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="vestibular1" fill="#330000" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="vestibular1" fill="#FFFF00" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="vestibular1" fill="#ff0000" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                  C56.29,10.08,87.28,10.29,99,21z"/>
                        </c:otherwise>    
                    </c:choose>
                    <!--cara palatina-->        
                    <c:choose>
                        <c:when test="${caraP.getRowCount()== 0}">
                            <path class="parte" id="palatinaLingual1" fill="#FFFFFF" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                  C68.49,68.12,81.18,70.1,85,64z"/>        
                        </c:when>
                        <c:when test="${caraP.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="palatinaLingual1" fill="#999999" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="palatinaLingual1" fill="#468847" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="palatinaLingual1" fill="#F89406" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="palatinaLingual1" fill="#B94A48" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="palatinaLingual1" fill="#3A87AD" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="palatinaLingual1" fill="#333333" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="palatinaLingual1" fill="#330066" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="palatinaLingual1" fill="#330000" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="palatinaLingual1" fill="#FFFF00" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="palatinaLingual1" fill="#ff0000" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                  C68.49,68.12,81.18,70.1,85,64z"/>
                        </c:otherwise>    
                    </c:choose>        
                    <!--cara oclusal-->        
                    <c:choose>
                        <c:when test="${caraO.getRowCount()== 0}">
                            <path class="parte" id="oclusal1" fill="#FFFFFF" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>        
                        </c:when>
                        <c:when test="${caraO.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="oclusal1" fill="#999999" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="oclusal1" fill="#468847" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="oclusal1" fill="#F89406" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="oclusal1" fill="#B94A48" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="oclusal1" fill="#3A87AD" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="oclusal1" fill="#333333" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="oclusal1" fill="#330066" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="oclusal1" fill="#330000" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="oclusal1" fill="#FFFF00" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="oclusal1" fill="#ff0000" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                        </c:otherwise>    
                    </c:choose>
                    <!--cara distal-->        
                    <c:choose>
                        <c:when test="${caraD.getRowCount()== 0}">
                            <path class="parte" id="distal1" fill="#FFFFFF" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                  C50.77,30.56,53.62,37.05,60,40z"/>        
                        </c:when>
                        <c:when test="${caraD.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="distal1" fill="#999999" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="distal1" fill="#468847" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="distal1" fill="#F89406" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="distal1" fill="#B94A48" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="distal1" fill="#3A87AD" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="distal1" fill="#333333" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="distal1" fill="#330066" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="distal1" fill="#330000" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="distal1" fill="#FFFF00" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="distal1" fill="#ff0000" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                  C50.77,30.56,53.62,37.05,60,40z"/>
                        </c:otherwise>    
                    </c:choose>        
                </g>
            </g>
        </svg>

    </c:when>
    <c:when test="${diente.getRowsByIndex()[0][0] > 10 && diente.getRowsByIndex()[0][0] < 19}">
        <script type="text/javascript">
            $(function(){
                $(".parte").click(function(ev){
                    //segundo cuadrante = al primero
                    var parte = $(this).attr("id");
                    if(parte=="oclusal1"){
                    
                        if($("#oclusal").attr("selected")){
                            $("#oclusal").attr("selected",false);    
                        }else{
                            $("#oclusal").attr("selected",true);    
                        }
                    
                    }else{
                        if(parte=="vestibular1"){
                        
                            if($("#vestibular").attr("selected")){
                                $("#vestibular").attr("selected",false);    
                            }else{
                                $("#vestibular").attr("selected",true);
                            }
                        
                        }else{
                            if(parte=="mesial1"){
                            
                                if($("#mesial").attr("selected")){
                                    $("#mesial").attr("selected",false);    
                                }else{
                                    $("#mesial").attr("selected",true);
                                }
                            
                            }else{
                                if(parte=="distal1"){
                                
                                    if($("#distal").attr("selected")){
                                        $("#distal").attr("selected",false);
                                    }else{
                                        $("#distal").attr("selected",true);    
                                    }
                                
                                }else{
                                    if(parte=="palatinaLingual1"){
                                    
                                        if($("#palatinaLingual").attr("selected")){
                                            $("#palatinaLingual").attr("selected",false);    
                                        }else{
                                            $("#palatinaLingual").attr("selected",true);
                                        }
                                    
                                    }
                                }   
                            }
                        }   
                    }
            
                })
            });
        </script>
        <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
             width="150px" height="100px" viewBox="0 0 150 100" enable-background="new 0 0 150 100" xml:space="preserve">
            <g id="XMLID_2_">
                <g>
                    <path d="M118,43c0,4.67,0,9.33,0,14c-4.9,18.44-17.17,29.49-35,35c-5,0-10,0-15,0c-18.73-4.94-30.92-16.41-36-35
                          c0-4.67,0-9.33,0-14c5.2-18.47,17.2-30.13,36-35c4.67,0,9.33,0,14,0C100.73,12.94,112.92,24.41,118,43z M101,75
                          c14.82-6.62,14.86-37.01,4-48c-7.26,2.74-10.65,9.35-15,15c2.51,5.07,2.51,12.92,0,18C93.59,65.07,98.14,69.19,101,75z M86,37
                          c5.04-4.62,10.56-8.77,13-16c-11.72-10.71-42.71-10.92-50,4c6.23,3.1,9.13,9.54,16,12C70.02,32.28,80.39,34.24,86,37z M98,80
                          c-3.25-6.42-6.83-12.5-13-16c-3.82,6.1-16.51,4.12-22,1c-2.65,6.01-9.45,7.89-11,15C63.25,88.8,86.75,88.8,98,80z M62,52
                          c1,15.79,26.09,14.28,25-2c-0.48-7.13-5.34-12.96-16-10C64.65,41.76,61.53,44.65,62,52z M60,60c-5-4.42-2.68-14.94,0-20
                          c-6.38-2.95-9.23-9.44-16-12c-9.38,11.15-9.71,39.32,4,46C52.72,70.05,56.85,65.51,60,60z"/>

                    <!--cuadrante 2-->
                    <!--cara distal-->
                    <c:choose>
                        <c:when test="${caraD.getRowCount()== 0}">
                            <path class="parte" id="distal1" fill="#FFFFFF" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                  C94.35,36.35,97.74,29.74,105,27z"/>        
                        </c:when>
                        <c:when test="${caraD.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="distal1" fill="#999999" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="distal1" fill="#468847" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="distal1" fill="#F89406" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="distal1" fill="#B94A48" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="distal1" fill="#3A87AD" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="distal1" fill="#333333" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="distal1" fill="#330066" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:when test="${caraD.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="distal1" fill="#330000" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="distal1" fill="#FFFF00" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                          C94.35,36.35,97.74,29.74,105,27z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="distal1" fill="#ff0000" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                  C94.35,36.35,97.74,29.74,105,27z"/>
                        </c:otherwise>    
                    </c:choose>
                    <!--cara vestibular-->
                    <c:choose>
                        <c:when test="${caraV.getRowCount()== 0}">
                            <path class="parte" id="vestibular1" fill="#FFFFFF" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                  C56.29,10.08,87.28,10.29,99,21z"/>        
                        </c:when>
                        <c:when test="${caraV.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="vestibular1" fill="#999999" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="vestibular1" fill="#468847" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="vestibular1" fill="#F89406" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="vestibular1" fill="#B94A48" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="vestibular1" fill="#3A87AD" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="vestibular1" fill="#333333" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="vestibular1" fill="#330066" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:when test="${caraV.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="vestibular1" fill="#330000" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="vestibular1" fill="#FFFF00" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                          C56.29,10.08,87.28,10.29,99,21z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="vestibular1" fill="#ff0000" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                  C56.29,10.08,87.28,10.29,99,21z"/>
                        </c:otherwise>    
                    </c:choose>
                    <!--cara palatina-->        
                    <c:choose>
                        <c:when test="${caraP.getRowCount()== 0}">
                            <path class="parte" id="palatinaLingual1" fill="#FFFFFF" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                  C68.49,68.12,81.18,70.1,85,64z"/>        
                        </c:when>
                        <c:when test="${caraP.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="palatinaLingual1" fill="#999999" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="palatinaLingual1" fill="#468847" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="palatinaLingual1" fill="#F89406" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="palatinaLingual1" fill="#B94A48" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="palatinaLingual1" fill="#3A87AD" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="palatinaLingual1" fill="#333333" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="palatinaLingual1" fill="#330066" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:when test="${caraP.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="palatinaLingual1" fill="#330000" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="palatinaLingual1" fill="#FFFF00" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                          C68.49,68.12,81.18,70.1,85,64z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="palatinaLingual1" fill="#ff0000" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                  C68.49,68.12,81.18,70.1,85,64z"/>
                        </c:otherwise>    
                    </c:choose>        
                    <!--cara oclusal-->        
                    <c:choose>
                        <c:when test="${caraO.getRowCount()== 0}">
                            <path class="parte" id="oclusal1" fill="#FFFFFF" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>        
                        </c:when>
                        <c:when test="${caraO.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="oclusal1" fill="#999999" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="oclusal1" fill="#468847" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="oclusal1" fill="#F89406" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="oclusal1" fill="#B94A48" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="oclusal1" fill="#3A87AD" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="oclusal1" fill="#333333" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="oclusal1" fill="#330066" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:when test="${caraO.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="oclusal1" fill="#330000" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="oclusal1" fill="#FFFF00" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="oclusal1" fill="#ff0000" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                        </c:otherwise>    
                    </c:choose>
                    <!--cara mesial-->        
                    <c:choose>
                        <c:when test="${caraM.getRowCount()== 0}">
                            <path class="parte" id="mesial1" fill="#FFFFFF" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                  C50.77,30.56,53.62,37.05,60,40z"/>        
                        </c:when>
                        <c:when test="${caraM.getRowCount()== 1}">
                            <c:choose>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Caries o recidiva'}">
                                    <path class="parte" id="mesial1" fill="#999999" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Obturado'}">
                                    <path class="parte" id="mesial1" fill="#468847" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Corona completa'}">
                                    <path class="parte" id="mesial1" fill="#F89406" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Ausente'}">
                                    <path class="parte" id="mesial1" fill="#B94A48" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Sellante'}">
                                    <path class="parte" id="mesial1" fill="#3A87AD" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Endodoncia indicada'}">
                                    <path class="parte" id="mesial1" fill="#333333" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Endodoncia'}">
                                    <path class="parte" id="mesial1" fill="#330066" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:when test="${caraM.getRowsByIndex()[0][4]=='Incluido'}">
                                    <path class="parte" id="mesial1" fill="#330000" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:when>
                                <c:otherwise>
                                    <path class="parte" id="mesial1" fill="#FFFF00" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                          C50.77,30.56,53.62,37.05,60,40z"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <path class="parte" id="mesial1" fill="#ff0000" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                  C50.77,30.56,53.62,37.05,60,40z"/>
                        </c:otherwise>    
                    </c:choose>        
                </g>
            </g>
        </svg>

    </c:when>
</c:choose>










