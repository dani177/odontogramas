/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Oscar Ballesteros
 */
@Entity
@Table(name = "datosbasicos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Datosbasicos.findAll", query = "SELECT d FROM Datosbasicos d"),
    @NamedQuery(name = "Datosbasicos.findByIddatosBasicos", query = "SELECT d FROM Datosbasicos d WHERE d.iddatosBasicos = :iddatosBasicos"),
    @NamedQuery(name = "Datosbasicos.findByNombre", query = "SELECT d FROM Datosbasicos d WHERE d.nombre = :nombre")})
public class Datosbasicos implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "iddatosBasicos")
    private Integer iddatosBasicos;
    @Column(name = "nombre")
    private String nombre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "datosBasicosiddatosBasicos")
    private List<DatosconsultaHasDatosbasicos> datosconsultaHasDatosbasicosList;

    public Datosbasicos() {
    }

    public Datosbasicos(Integer iddatosBasicos) {
        this.iddatosBasicos = iddatosBasicos;
    }

    public Integer getIddatosBasicos() {
        return iddatosBasicos;
    }

    public void setIddatosBasicos(Integer iddatosBasicos) {
        this.iddatosBasicos = iddatosBasicos;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @XmlTransient
    public List<DatosconsultaHasDatosbasicos> getDatosconsultaHasDatosbasicosList() {
        return datosconsultaHasDatosbasicosList;
    }

    public void setDatosconsultaHasDatosbasicosList(List<DatosconsultaHasDatosbasicos> datosconsultaHasDatosbasicosList) {
        this.datosconsultaHasDatosbasicosList = datosconsultaHasDatosbasicosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddatosBasicos != null ? iddatosBasicos.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Datosbasicos)) {
            return false;
        }
        Datosbasicos other = (Datosbasicos) object;
        if ((this.iddatosBasicos == null && other.iddatosBasicos != null) || (this.iddatosBasicos != null && !this.iddatosBasicos.equals(other.iddatosBasicos))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Datosbasicos[ iddatosBasicos=" + iddatosBasicos + " ]";
    }
    
}
