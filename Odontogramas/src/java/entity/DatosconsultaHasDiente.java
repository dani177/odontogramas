/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;


@Entity
@Table(name = "datosconsulta_has_diente")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "DatosconsultaHasDiente.findAll", query = "SELECT d FROM DatosconsultaHasDiente d"),
    @NamedQuery(name = "DatosconsultaHasDiente.findByDatosConsultaiddatosConsulta", query = "SELECT d FROM DatosconsultaHasDiente d WHERE d.datosconsultaHasDientePK.datosConsultaiddatosConsulta = :datosConsultaiddatosConsulta"),
    @NamedQuery(name = "DatosconsultaHasDiente.findByDienteIddiente", query = "SELECT d FROM DatosconsultaHasDiente d WHERE d.datosconsultaHasDientePK.dienteIddiente = :dienteIddiente"),
    @NamedQuery(name = "DatosconsultaHasDiente.findByCara", query = "SELECT d FROM DatosconsultaHasDiente d WHERE d.cara = :cara"),
    @NamedQuery(name = "DatosconsultaHasDiente.findByEnfermedad", query = "SELECT d FROM DatosconsultaHasDiente d WHERE d.enfermedad = :enfermedad")})
public class DatosconsultaHasDiente implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected DatosconsultaHasDientePK datosconsultaHasDientePK;
    @Column(name = "cara")
    private String cara;
    @Column(name = "enfermedad")
    private String enfermedad;
    @JoinColumn(name = "diente_iddiente", referencedColumnName = "iddiente", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Diente diente;
    @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Consulta consulta;

    public DatosconsultaHasDiente() {
    }

    public DatosconsultaHasDiente(DatosconsultaHasDientePK datosconsultaHasDientePK) {
        this.datosconsultaHasDientePK = datosconsultaHasDientePK;
    }

    public DatosconsultaHasDiente(int datosConsultaiddatosConsulta, int dienteIddiente) {
        this.datosconsultaHasDientePK = new DatosconsultaHasDientePK(datosConsultaiddatosConsulta, dienteIddiente);
    }

    public DatosconsultaHasDientePK getDatosconsultaHasDientePK() {
        return datosconsultaHasDientePK;
    }

    public void setDatosconsultaHasDientePK(DatosconsultaHasDientePK datosconsultaHasDientePK) {
        this.datosconsultaHasDientePK = datosconsultaHasDientePK;
    }

    public String getCara() {
        return cara;
    }

    public void setCara(String cara) {
        this.cara = cara;
    }

    public String getEnfermedad() {
        return enfermedad;
    }

    public void setEnfermedad(String enfermedad) {
        this.enfermedad = enfermedad;
    }

    public Diente getDiente() {
        return diente;
    }

    public void setDiente(Diente diente) {
        this.diente = diente;
    }

    public Consulta getConsulta() {
        return consulta;
    }

    public void setConsulta(Consulta consulta) {
        this.consulta = consulta;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (datosconsultaHasDientePK != null ? datosconsultaHasDientePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DatosconsultaHasDiente)) {
            return false;
        }
        DatosconsultaHasDiente other = (DatosconsultaHasDiente) object;
        if ((this.datosconsultaHasDientePK == null && other.datosconsultaHasDientePK != null) || (this.datosconsultaHasDientePK != null && !this.datosconsultaHasDientePK.equals(other.datosconsultaHasDientePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.DatosconsultaHasDiente[ datosconsultaHasDientePK=" + datosconsultaHasDientePK + " ]";
    }

}
