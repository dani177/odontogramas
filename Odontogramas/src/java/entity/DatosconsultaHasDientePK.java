/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;


@Embeddable
public class DatosconsultaHasDientePK implements Serializable {
    @Basic(optional = false)
    @Column(name = "datosConsulta_iddatosConsulta")
    private int datosConsultaiddatosConsulta;
    @Basic(optional = false)
    @Column(name = "diente_iddiente")
    private int dienteIddiente;

    public DatosconsultaHasDientePK() {
    }

    public DatosconsultaHasDientePK(int datosConsultaiddatosConsulta, int dienteIddiente) {
        this.datosConsultaiddatosConsulta = datosConsultaiddatosConsulta;
        this.dienteIddiente = dienteIddiente;
    }

    public int getDatosConsultaiddatosConsulta() {
        return datosConsultaiddatosConsulta;
    }

    public void setDatosConsultaiddatosConsulta(int datosConsultaiddatosConsulta) {
        this.datosConsultaiddatosConsulta = datosConsultaiddatosConsulta;
    }

    public int getDienteIddiente() {
        return dienteIddiente;
    }

    public void setDienteIddiente(int dienteIddiente) {
        this.dienteIddiente = dienteIddiente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) datosConsultaiddatosConsulta;
        hash += (int) dienteIddiente;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DatosconsultaHasDientePK)) {
            return false;
        }
        DatosconsultaHasDientePK other = (DatosconsultaHasDientePK) object;
        if (this.datosConsultaiddatosConsulta != other.datosConsultaiddatosConsulta) {
            return false;
        }
        if (this.dienteIddiente != other.dienteIddiente) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.DatosconsultaHasDientePK[ datosConsultaiddatosConsulta=" + datosConsultaiddatosConsulta + ", dienteIddiente=" + dienteIddiente + " ]";
    }

}
