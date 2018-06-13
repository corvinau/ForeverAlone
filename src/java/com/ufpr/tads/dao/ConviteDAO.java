/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.dao;

import com.ufpr.tads.beans.Casamento;
import com.ufpr.tads.beans.Convite;
import com.ufpr.tads.beans.Encontro;
import com.ufpr.tads.beans.Festa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ArtVin
 */
public class ConviteDAO {
    private Connection con;
    private ResultSet rs;
    
    
    public ConviteDAO(){
        try {
            con = ConnectionFactory.getConnection();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public ConviteDAO(Connection con){
        this.con = con;
    }
    
 
    public int insertConvite(Convite convite) {
        PreparedStatement st;
        
        try {
            st = con.prepareStatement(
                    "INSERT INTO convite(status,tipo,Cliente_idCliente) "
                    + "VALUES(?,?,?)",Statement.RETURN_GENERATED_KEYS
            );
            st.setString(1,convite.getStatus());
            st.setString(2, convite.getTipo());
            st.setInt(3, convite.getConvidado().getIdCliente());
         
            st.executeUpdate();
            rs = st.getGeneratedKeys();
            if(rs.next()) return rs.getInt(1);
            
            
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        
        return 0;
    }

    public List<Convite> getListaConviteClienteAguardando(int idCliente) {
        List<Convite> lista = new ArrayList<Convite>();
        PreparedStatement st;
        Convite convite;
        try {
            st = con.prepareStatement(
                      "SELECT C.IDCONVITE, C.STATUS, C.TIPO "
                    + "FROM convite C "
                    + "WHERE C.CLIENTE_IDCLIENTE = ? AND STATUS = 'Aguardando'"
            );
            st.setInt(1,idCliente);
         
            rs = st.executeQuery();
            
            FestaDAO festaDao = new FestaDAO(con);
            EncontroDAO encontroDao = new EncontroDAO(con);
            CasamentoDAO casamentoDao = new CasamentoDAO(con);
            
            while(rs.next()){
                convite = new Convite();
                convite.setIdConvite(rs.getInt("C.IDCONVITE"));
                convite.setStatus("Aguardando");
                convite.setTipo(rs.getString("C.TIPO"));
                switch (convite.getTipo().toLowerCase()){
                    case "f":
                        Festa f = festaDao.getFestaByConvite(convite.getIdConvite());
                        if(f != null && f.getIdFesta() > 0){
                            convite.setEvento(f);
                        }
                        break;
                    case "e":
                        Encontro e = encontroDao.getEncontroByConvite(convite.getIdConvite());
                        if(e != null && e.getId() > 0){
                            convite.setEvento(e);
                        }
                        break;
                    case "c":
                        Casamento c = casamentoDao.getCasamentoByConvite(convite.getIdConvite());
                        if(c != null && c.getId() > 0){
                            convite.setEvento(c);
                        }
                        break;
                }
                lista.add(convite);
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        
        return lista;
    }
}
