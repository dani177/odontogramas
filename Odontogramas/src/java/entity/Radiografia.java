/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
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
@Table(name = "radiografia")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Radiografia.findAll", query = "SELECT r FROM Radiografia r"),
    @NamedQuery(name = "Radiografia.findByIdradiografia", query = "SELECT r FROM Radiografia r WHERE r.idradiografia = :idradiografia"),
    @NamedQuery(name = "Radiografia.findByNombre", query = "SELECT r FROM Radiografia r WHERE r.nombre = :nombre"),
    @NamedQuery(name = "Radiografia.findByRuta", query = "SELECT r FROM Radiografia r WHERE r.ruta = :ruta")})
public class Radiografia implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "idradiografia")
    private Integer idradiografia;
    @Column(name = "nombre")
    private String nombre;
    @Column(name = "ruta")
    private String ruta;
    @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta")
    @ManyToOne(optional = false)
    private Consulta datosConsultaiddatosConsulta;

    public Radiografia() {
    }

    public Radiografia(Integer idradiografia) {
        this.idradiografia = idradiografia;
    }

    public Integer getIdradiografia() {
        return idradiografia;
    }

    public void setIdradiografia(Integer idradiografia) {
        this.idradiografia = idradiografia;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRuta() {
        return ruta;
    }

    public void setRuta(String ruta) {
        this.ruta = ruta;
    }

    public Consulta getDatosConsultaiddatosConsulta() {
        return datosConsultaiddatosConsulta;
    }

    public void setDatosConsultaiddatosConsulta(Consulta datosConsultaiddatosConsulta) {
        this.datosConsultaiddatosConsulta = datosConsultaiddatosConsulta;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idradiografia != null ? idradiografia.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Radiografia)) {
            return false;
        }
        Radiografia other = (Radiografia) object;
        if ((this.idradiografia == null && other.idradiografia != null) || (this.idradiografia != null && !this.idradiografia.equals(other.idradiografia))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Radiografia[ idradiografia=" + idradiografia + " ]";
    }
    
}
