/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;


@Entity
@Table(name = "datosconsulta")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Datosconsulta.findAll", query = "SELECT d FROM Datosconsulta d"),
    @NamedQuery(name = "Datosconsulta.findByIddatosConsulta", query = "SELECT d FROM Datosconsulta d WHERE d.iddatosConsulta = :iddatosConsulta"),
    @NamedQuery(name = "Datosconsulta.findByMotivoConsulta", query = "SELECT d FROM Datosconsulta d WHERE d.motivoConsulta = :motivoConsulta"),
    @NamedQuery(name = "Datosconsulta.findByHistoriaActualEnfermedad", query = "SELECT d FROM Datosconsulta d WHERE d.historiaActualEnfermedad = :historiaActualEnfermedad"),
    @NamedQuery(name = "Datosconsulta.findByObservaciones", query = "SELECT d FROM Datosconsulta d WHERE d.observaciones = :observaciones"),
    @NamedQuery(name = "Datosconsulta.findByOtros", query = "SELECT d FROM Datosconsulta d WHERE d.otros = :otros"),
    @NamedQuery(name = "Datosconsulta.findByUltimaVisitaOdon", query = "SELECT d FROM Datosconsulta d WHERE d.ultimaVisitaOdon = :ultimaVisitaOdon"),
    @NamedQuery(name = "Datosconsulta.findByMotivo", query = "SELECT d FROM Datosconsulta d WHERE d.motivo = :motivo")})
public class Datosconsulta implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "iddatosConsulta")
    private Integer iddatosConsulta;
    @Column(name = "motivoConsulta")
    private String motivoConsulta;
    @Column(name = "historiaActualEnfermedad")
    private String historiaActualEnfermedad;
    @Column(name = "observaciones")
    private String observaciones;
    @Column(name = "otros")
    private String otros;
    @Column(name = "ultimaVisitaOdon")
    @Temporal(TemporalType.DATE)
    private Date ultimaVisitaOdon;
    @Column(name = "motivo")
    private String motivo;
    @JoinColumn(name = "paciente_idpersona", referencedColumnName = "idpersona")
    @ManyToOne(optional = false)
    private Paciente pacienteIdpersona;

    public Datosconsulta() {
    }

    public Datosconsulta(Integer iddatosConsulta) {
        this.iddatosConsulta = iddatosConsulta;
    }

    public Integer getIddatosConsulta() {
        return iddatosConsulta;
    }

    public void setIddatosConsulta(Integer iddatosConsulta) {
        this.iddatosConsulta = iddatosConsulta;
    }

    public String getMotivoConsulta() {
        return motivoConsulta;
    }

    public void setMotivoConsulta(String motivoConsulta) {
        this.motivoConsulta = motivoConsulta;
    }

    public String getHistoriaActualEnfermedad() {
        return historiaActualEnfermedad;
    }

    public void setHistoriaActualEnfermedad(String historiaActualEnfermedad) {
        this.historiaActualEnfermedad = historiaActualEnfermedad;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getOtros() {
        return otros;
    }

    public void setOtros(String otros) {
        this.otros = otros;
    }

    public Date getUltimaVisitaOdon() {
        return ultimaVisitaOdon;
    }

    public void setUltimaVisitaOdon(Date ultimaVisitaOdon) {
        this.ultimaVisitaOdon = ultimaVisitaOdon;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public Paciente getPacienteIdpersona() {
        return pacienteIdpersona;
    }

    public void setPacienteIdpersona(Paciente pacienteIdpersona) {
        this.pacienteIdpersona = pacienteIdpersona;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddatosConsulta != null ? iddatosConsulta.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Datosconsulta)) {
            return false;
        }
        Datosconsulta other = (Datosconsulta) object;
        if ((this.iddatosConsulta == null && other.iddatosConsulta != null) || (this.iddatosConsulta != null && !this.iddatosConsulta.equals(other.iddatosConsulta))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Datosconsulta[ iddatosConsulta=" + iddatosConsulta + " ]";
    }

}
