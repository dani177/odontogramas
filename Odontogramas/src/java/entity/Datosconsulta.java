/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


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
    @NamedQuery(name = "Datosconsulta.findByMotivo", query = "SELECT d FROM Datosconsulta d WHERE d.motivo = :motivo"),
    @NamedQuery(name = "Datosconsulta.findByFechaConsulta", query = "SELECT d FROM Datosconsulta d WHERE d.fechaConsulta = :fechaConsulta"),
    @NamedQuery(name = "Datosconsulta.findByPronostico", query = "SELECT d FROM Datosconsulta d WHERE d.pronostico = :pronostico")})
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
    @Column(name = "fechaConsulta")
    @Temporal(TemporalType.DATE)
    private Date fechaConsulta;
    @Column(name = "pronostico")
    private String pronostico;
    @JoinTable(name = "datosconsulta_has_tratamiento", joinColumns = {
        @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta")}, inverseJoinColumns = {
        @JoinColumn(name = "tratamiento_idtratamiento", referencedColumnName = "idtratamiento")})
    @ManyToMany
    private List<Tratamiento> tratamientoList;
    @JoinTable(name = "datosconsulta_has_diagnostico", joinColumns = {
        @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta")}, inverseJoinColumns = {
        @JoinColumn(name = "diagnostico_iddiagnostico", referencedColumnName = "iddiagnostico")})
    @ManyToMany
    private List<Diagnostico> diagnosticoList;
    @JoinTable(name = "datosconsulta_has_plantratamiento", joinColumns = {
        @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta")}, inverseJoinColumns = {
        @JoinColumn(name = "planTratamiento_idplanTratamiento", referencedColumnName = "idplanTratamiento")})
    @ManyToMany
    private List<Plantratamiento> plantratamientoList;
    @JoinColumn(name = "medico_idmedico", referencedColumnName = "idmedico")
    @ManyToOne(optional = false)
    private Medico medicoIdmedico;
    @JoinColumn(name = "paciente_idpersona", referencedColumnName = "idpersona")
    @ManyToOne(optional = false)
    private Paciente pacienteIdpersona;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "datosconsulta")
    private List<DatosconsultaHasDiente> datosconsultaHasDienteList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "datosConsultaiddatosConsulta")
    private List<Examenfisicoestomatologico> examenfisicoestomatologicoList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "datosConsultaiddatosConsulta")
    private List<Radiografia> radiografiaList;

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

    public Date getFechaConsulta() {
        return fechaConsulta;
    }

    public void setFechaConsulta(Date fechaConsulta) {
        this.fechaConsulta = fechaConsulta;
    }

    public String getPronostico() {
        return pronostico;
    }

    public void setPronostico(String pronostico) {
        this.pronostico = pronostico;
    }

    @XmlTransient
    public List<Tratamiento> getTratamientoList() {
        return tratamientoList;
    }

    public void setTratamientoList(List<Tratamiento> tratamientoList) {
        this.tratamientoList = tratamientoList;
    }

    @XmlTransient
    public List<Diagnostico> getDiagnosticoList() {
        return diagnosticoList;
    }

    public void setDiagnosticoList(List<Diagnostico> diagnosticoList) {
        this.diagnosticoList = diagnosticoList;
    }

    @XmlTransient
    public List<Plantratamiento> getPlantratamientoList() {
        return plantratamientoList;
    }

    public void setPlantratamientoList(List<Plantratamiento> plantratamientoList) {
        this.plantratamientoList = plantratamientoList;
    }

    public Medico getMedicoIdmedico() {
        return medicoIdmedico;
    }

    public void setMedicoIdmedico(Medico medicoIdmedico) {
        this.medicoIdmedico = medicoIdmedico;
    }

    public Paciente getPacienteIdpersona() {
        return pacienteIdpersona;
    }

    public void setPacienteIdpersona(Paciente pacienteIdpersona) {
        this.pacienteIdpersona = pacienteIdpersona;
    }

    @XmlTransient
    public List<DatosconsultaHasDiente> getDatosconsultaHasDienteList() {
        return datosconsultaHasDienteList;
    }

    public void setDatosconsultaHasDienteList(List<DatosconsultaHasDiente> datosconsultaHasDienteList) {
        this.datosconsultaHasDienteList = datosconsultaHasDienteList;
    }

    @XmlTransient
    public List<Examenfisicoestomatologico> getExamenfisicoestomatologicoList() {
        return examenfisicoestomatologicoList;
    }

    public void setExamenfisicoestomatologicoList(List<Examenfisicoestomatologico> examenfisicoestomatologicoList) {
        this.examenfisicoestomatologicoList = examenfisicoestomatologicoList;
    }

    @XmlTransient
    public List<Radiografia> getRadiografiaList() {
        return radiografiaList;
    }

    public void setRadiografiaList(List<Radiografia> radiografiaList) {
        this.radiografiaList = radiografiaList;
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
