using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace _SERVICE_MARKET_.Models
{
    public class MantenimientoServicios
    {
        /*CADENA DE CONEXION*/
        IDbConnection cadena = DbCommon.Conexion();

        /*VARIABLE SESION CON LA IDENTIFICACION DEL USUARIO QUE INGRESO*/
        Usuario usuario = HttpContext.Current.Session["Usuario"] as Usuario;

        //METODO PARA AGREGAR SERVICIOS
        public int AgregarServicio(Servicio oServicios)
        {
            cadena.Open();
            SqlCommand Comand = new SqlCommand("CREAR_SERVICIOS", cadena as SqlConnection);
            Comand.CommandType = CommandType.StoredProcedure;
            Comand.Parameters.Add(new SqlParameter("@NOMBRE_SER", oServicios.NOMBRE_SER));
            Comand.Parameters.Add(new SqlParameter("@PRECIO_SER", oServicios.PRECIO_SER));
            Comand.Parameters.Add(new SqlParameter("@DESCRIPCION_BREVE", oServicios.DESCRIPCION_BREVE));
            Comand.Parameters.Add(new SqlParameter("@TERMINOS_SER", oServicios.TERMINOS_SER));
            Comand.Parameters.Add(new SqlParameter("@TIPO", oServicios.TIPO));
            Comand.Parameters.Add(new SqlParameter("@N_IDENTIFICACION_USU_FK", usuario.N_IDENTIFICACION_USU));
            Comand.Parameters.Add(new SqlParameter("@ID_CATEGORIA_FK", oServicios.ID_CATEGORIA_FK));
            int Publicacion = Comand.ExecuteNonQuery();
            cadena.Close();
            return Publicacion;
        }

        //METODO PARA CONSULTAR PUBLICACIONES DE SERVICIOS
        public List<Servicio> ConsultarServicios()
        {
            cadena.Open();
            List<Servicio> lista = new List<Servicio>();
            SqlCommand Comand = new SqlCommand("CONSULTAR_SERVICIOS", cadena as SqlConnection);
            Comand.CommandType = CommandType.StoredProcedure;
            SqlDataReader reader = Comand.ExecuteReader();

            while (reader.Read())
            {
                Servicio oServicios = new Servicio
                {
                    ID_SERVICIO = int.Parse(reader["ID_SERVICIO"].ToString()),
                    NOMBRE_SER = reader["NOMBRE_SER"].ToString(),
                    PRECIO_SER = decimal.Parse(reader["PRECIO_SER"].ToString()),
                    DESCRIPCION_BREVE = reader["DESCRIPCION_BREVE"].ToString(),
                    NOMBRE_CAT = reader["NOMBRE_CAT"].ToString()
                };
                lista.Add(oServicios);
            }
            cadena.Close();
            return lista;
        }

        //METODO PARA CONSULTAR SOLICITUDES DE SERVICIOS
        public List<Servicio> ConsultarSolicitudes()
        {
            cadena.Open();
            List<Servicio> lista = new List<Servicio>();
            SqlCommand Comand = new SqlCommand("CONSULTAR_SOLICITUDES", cadena as SqlConnection);
            Comand.CommandType = CommandType.StoredProcedure;
            SqlDataReader reader = Comand.ExecuteReader();

            while (reader.Read())
            {
                Servicio oServicios = new Servicio
                {
                    ID_SERVICIO = int.Parse(reader["ID_SERVICIO"].ToString()),
                    NOMBRE_SER = reader["NOMBRE_SER"].ToString(),
                    PRECIO_SER = decimal.Parse(reader["PRECIO_SER"].ToString()),
                    DESCRIPCION_BREVE = reader["DESCRIPCION_BREVE"].ToString(),
                    NOMBRE_CAT = reader["NOMBRE_CAT"].ToString()
                };
                lista.Add(oServicios);
            }
            cadena.Close();
            return lista;
        }


        //METODO PARA CONSULTAR MAS INFORMACION SOBRE UN SERVICIO
        public Servicio informacionPublicacion(int ID_SERVICIO)
        {
            cadena.Open();
            SqlCommand Comand = new SqlCommand("INFORMACION_PUBLICACION", cadena as SqlConnection);
            Comand.Parameters.Add("@ID_SERVICIO", SqlDbType.Int);
            Comand.Parameters["@ID_SERVICIO"].Value = ID_SERVICIO;
            Comand.CommandType = CommandType.StoredProcedure;
            SqlDataReader reader = Comand.ExecuteReader();

            Servicio oDetalle_Servicios = new Servicio();
            if (reader.Read())
            {
                oDetalle_Servicios.ID_SERVICIO = int.Parse(reader["ID_SERVICIO"].ToString());
                oDetalle_Servicios.NOMBRE_SER = reader["NOMBRE_SER"].ToString();
                oDetalle_Servicios.PRECIO_SER = decimal.Parse(reader["PRECIO_SER"].ToString());
                oDetalle_Servicios.DESCRIPCION_BREVE = reader["DESCRIPCION_BREVE"].ToString();
                oDetalle_Servicios.TERMINOS_SER = reader["TERMINOS_SER"].ToString();
                oDetalle_Servicios.TIPO = reader["TIPO"].ToString();
                oDetalle_Servicios.NOMBRE_CAT = reader["NOMBRE_CAT"].ToString();
                oDetalle_Servicios.N_IDENTIFICACION_USU = reader["N_IDENTIFICACION_USU"].ToString();
                oDetalle_Servicios.NOMBRE_USU = reader["NOMBRE_USU"].ToString();
                oDetalle_Servicios.APELLIDOS_USU = reader["APELLIDOS_USU"].ToString();
                oDetalle_Servicios.CELULAR_USU = reader["CELULAR_USU"].ToString();
                oDetalle_Servicios.NOMBRE_CIUDAD = reader["NOMBRE_CIUDAD"].ToString();
            }
            cadena.Close();
            return oDetalle_Servicios;
        }

        //METODO PARA BUSCAR SERVICIOS
        public List<Servicio> BuscarServicios(string NOMBRE_SER)
        {
            cadena.Open();
            List<Servicio> lista = new List<Servicio>();
            SqlCommand Comand = new SqlCommand("BUSQUEDAD_SERVICIOS", cadena as SqlConnection);
            Comand.Parameters.Add("@NOMBRE_SER", SqlDbType.VarChar);
            Comand.Parameters["@NOMBRE_SER"].Value = '%' + NOMBRE_SER + '%';
            Comand.CommandType = CommandType.StoredProcedure;
            SqlDataReader reader = Comand.ExecuteReader();

            while (reader.Read())
            {
                Servicio oServicios = new Servicio
                {
                    ID_SERVICIO = int.Parse(reader["ID_SERVICIO"].ToString()),
                    NOMBRE_SER = reader["NOMBRE_SER"].ToString(),
                    PRECIO_SER = decimal.Parse(reader["PRECIO_SER"].ToString()),
                    DESCRIPCION_BREVE = reader["DESCRIPCION_BREVE"].ToString(),
                    NOMBRE_CAT = reader["NOMBRE_CAT"].ToString()
                };
                lista.Add(oServicios);
            }
            cadena.Close();
            return lista;
        }

    }
}