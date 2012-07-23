/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Oscar
 */
@Entity
@Table(name = "examenfisicoestomatologico")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Examenfisicoestomatologico.findAll", query = "SELECT e FROM Examenfisicoestomatologico e"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByIdexamenFisicoEstomatologico", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.idexamenFisicoEstomatologico = :idexamenFisicoEstomatologico"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByTemperatura", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.temperatura = :temperatura"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByPulso", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.pulso = :pulso"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByTensionArterial", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.tensionArterial = :tensionArterial"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByHigieneOral", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.higieneOral = :higieneOral"),
    @NamedQuery(name = "Examenfisicoestomatologico.findBySedaDental", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.sedaDental = :sedaDental"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByCepilloDentalUso", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.cepilloDentalUso = :cepilloDentalUso"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByVecesAlDia", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.vecesAlDia = :vecesAlDia"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByEnjuagesBsinFluor", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.enjuagesBsinFluor = :enjuagesBsinFluor"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByEnjuagesBconFluor", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.enjuagesBconFluor = :enjuagesBconFluor"),
    @NamedQuery(name = "Examenfisicoestomatologico.findByHabitosYvicios", query = "SELECT e FROM Examenfisicoestomatologico e WHERE e.habitosYvicios = :habitosYvicios")})
public class Examenfisicoestomatologico implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idexamenFisicoEstomatologico")
    private Integer idexamenFisicoEstomatologico;
    @Column(name = "temperatura")
    private String temperatura;
    @Column(name = "pulso")
    private String pulso;
    @Column(name = "tensionArterial")
    private String tensionArterial;
    @Column(name = "higieneOral")
    private String higieneOral;
    @Column(name = "sedaDental")
    private String sedaDental;
    @Column(name = "cepilloDentalUso")
    private String cepilloDentalUso;
    @Column(name = "vecesAlDia")
    private String vecesAlDia;
    @Column(name = "enjuagesBsinFluor")
    private String enjuagesBsinFluor;
    @Column(name = "enjuagesBconFluor")
    private String enjuagesBconFluor;
    @Column(name = "habitosYvicios")
    private String habitosYvicios;
    @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta")
    @ManyToOne(optional = false)
    private Datosconsulta datosConsultaiddatosConsulta;

    public Examenfisicoestomatologico() {
    }

    public Examenfisicoestomatologico(Integer idexamenFisicoEstomatologico) {
        this.idexamenFisicoEstomatologico = idexamenFisicoEstomatologico;
    }

    public Integer getIdexamenFisicoEstomatologico() {
        return idexamenFisicoEstomatologico;
    }

    public void setIdexamenFisicoEstomatologico(Integer idexamenFisicoEstomatologico) {
        this.idexamenFisicoEstomatologico = idexamenFisicoEstomatologico;
    }

    public String getTemperatura() {
        return temperatura;
    }

    public void setTemperatura(String temperatura) {
        this.temperatura = temperatura;
    }

    public String getPulso() {
        return pulso;
    }

    public void setPulso(String pulso) {
        this.pulso = pulso;
    }

    public String getTensionArterial() {
        return tensionArterial;
    }

    public void setTensionArterial(String tensionArterial) {
        this.tensionArterial = tensionArterial;
    }

    public String getHigieneOral() {
        return higieneOral;
    }

    public void setHigieneOral(String higieneOral) {
        this.higieneOral = higieneOral;
    }

    public String getSedaDental() {
        return sedaDental;
    }

    public void setSedaDental(String sedaDental) {
        this.sedaDental = sedaDental;
    }

    public String getCepilloDentalUso() {
        return cepilloDentalUso;
    }

    public void setCepilloDentalUso(String cepilloDentalUso) {
        this.cepilloDentalUso = cepilloDentalUso;
    }

    public String getVecesAlDia() {
        return vecesAlDia;
    }

    public void setVecesAlDia(String vecesAlDia) {
        this.vecesAlDia = vecesAlDia;
    }

    public String getEnjuagesBsinFluor() {
        return enjuagesBsinFluor;
    }

    public void setEnjuagesBsinFluor(String enjuagesBsinFluor) {
        this.enjuagesBsinFluor = enjuagesBsinFluor;
    }

    public String getEnjuagesBconFluor() {
        return enjuagesBconFluor;
    }

    public void setEnjuagesBconFluor(String enjuagesBconFluor) {
        this.enjuagesBconFluor = enjuagesBconFluor;
    }

    public String getHabitosYvicios() {
        return habitosYvicios;
    }

    public void setHabitosYvicios(String habitosYvicios) {
        this.habitosYvicios = habitosYvicios;
    }

    public Datosconsulta getDatosConsultaiddatosConsulta() {
        return datosConsultaiddatosConsulta;
    }

    public void setDatosConsultaiddatosConsulta(Datosconsulta datosConsultaiddatosConsulta) {
        this.datosConsultaiddatosConsulta = datosConsultaiddatosConsulta;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idexamenFisicoEstomatologico != null ? idexamenFisicoEstomatologico.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Examenfisicoestomatologico)) {
            return false;
        }
        Examenfisicoestomatologico other = (Examenfisicoestomatologico) object;
        if ((this.idexamenFisicoEstomatologico == null && other.idexamenFisicoEstomatologico != null) || (this.idexamenFisicoEstomatologico != null && !this.idexamenFisicoEstomatologico.equals(other.idexamenFisicoEstomatologico))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Examenfisicoestomatologico[ idexamenFisicoEstomatologico=" + idexamenFisicoEstomatologico + " ]";
    }
    
}
