/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Oscar Ballesteros
 */
@Entity
@Table(name = "datosconsulta_has_datosbasicos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "DatosconsultaHasDatosbasicos.findAll", query = "SELECT d FROM DatosconsultaHasDatosbasicos d"),
    @NamedQuery(name = "DatosconsultaHasDatosbasicos.findByValor", query = "SELECT d FROM DatosconsultaHasDatosbasicos d WHERE d.valor = :valor"),
    @NamedQuery(name = "DatosconsultaHasDatosbasicos.findByIdConsultadatosBasicos", query = "SELECT d FROM DatosconsultaHasDatosbasicos d WHERE d.idConsultadatosBasicos = :idConsultadatosBasicos")})
public class DatosconsultaHasDatosbasicos implements Serializable {
    private static final long serialVersionUID = 1L;
    @Column(name = "valor")
    private String valor;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idConsulta_datosBasicos")
    private Integer idConsultadatosBasicos;
    @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta")
    @ManyToOne(optional = false)
    private Consulta datosConsultaiddatosConsulta;
    @JoinColumn(name = "datosBasicos_iddatosBasicos", referencedColumnName = "iddatosBasicos")
    @ManyToOne(optional = false)
    private Datosbasicos datosBasicosiddatosBasicos;

    public DatosconsultaHasDatosbasicos() {
    }

    public DatosconsultaHasDatosbasicos(Integer idConsultadatosBasicos) {
        this.idConsultadatosBasicos = idConsultadatosBasicos;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public Integer getIdConsultadatosBasicos() {
        return idConsultadatosBasicos;
    }

    public void setIdConsultadatosBasicos(Integer idConsultadatosBasicos) {
        this.idConsultadatosBasicos = idConsultadatosBasicos;
    }

    public Consulta getDatosConsultaiddatosConsulta() {
        return datosConsultaiddatosConsulta;
    }

    public void setDatosConsultaiddatosConsulta(Consulta datosConsultaiddatosConsulta) {
        this.datosConsultaiddatosConsulta = datosConsultaiddatosConsulta;
    }

    public Datosbasicos getDatosBasicosiddatosBasicos() {
        return datosBasicosiddatosBasicos;
    }

    public void setDatosBasicosiddatosBasicos(Datosbasicos datosBasicosiddatosBasicos) {
        this.datosBasicosiddatosBasicos = datosBasicosiddatosBasicos;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idConsultadatosBasicos != null ? idConsultadatosBasicos.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DatosconsultaHasDatosbasicos)) {
            return false;
        }
        DatosconsultaHasDatosbasicos other = (DatosconsultaHasDatosbasicos) object;
        if ((this.idConsultadatosBasicos == null && other.idConsultadatosBasicos != null) || (this.idConsultadatosBasicos != null && !this.idConsultadatosBasicos.equals(other.idConsultadatosBasicos))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.DatosconsultaHasDatosbasicos[ idConsultadatosBasicos=" + idConsultadatosBasicos + " ]";
    }
    
}
