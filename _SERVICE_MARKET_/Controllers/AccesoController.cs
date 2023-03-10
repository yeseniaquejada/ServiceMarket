using _SERVICE_MARKET_.Models;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using System.Web.Security;

namespace _SERVICE_MARKET_.Controllers
{
    public class AccesoController : Controller
    {
        // GET: Acceso

        /*CADENA DE CONEXION*/
        static string cadena = "Data Source=LAPTOP-RMAAM810;Initial Catalog=SERVICE_MARKET;Integrated Security=True";

        // GET: Acceso
        public ActionResult Login()
        {
            return View();
        }

        public ActionResult Registrar()
        {
            return View();
        }

        /*METODO REGISTRAR*/
        [HttpPost]
        public ActionResult Registrar(Usuario oUsuarios)
        {
            bool registrado;
            string mensaje;

            /*COMPARANDO CONTRASEÑAS*/
            if (oUsuarios.CONTRASENA_USU == oUsuarios.CONFIRMAR_CONTRASENA)
            {
                /*ENCRIPTANDO CONTRASEÑA*/
                oUsuarios.CONTRASENA_USU = ConvertirSha256(oUsuarios.CONTRASENA_USU);
            }
            else
            {
                ViewData["MENSAJE"] = "Las contraseñas no coinciden";
                return View();
            }

            /*CONECTANDO BASE DE DATOS*/
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                /*PROCEDIMIENTO ALMACENADO REGISTRAR USUARIO*/
                SqlCommand cmd = new SqlCommand("REGISTRAR_USUARIO", cn);
                cmd.Parameters.AddWithValue("TIPO_DOC_USU", oUsuarios.TIPO_DOC_USU);
                cmd.Parameters.AddWithValue("N_IDENTIFICACION_USU", oUsuarios.N_IDENTIFICACION_USU);
                cmd.Parameters.AddWithValue("FECHA_NACIMIENTO_USU", oUsuarios.FECHA_NACIMIENTO_USU);
                cmd.Parameters.AddWithValue("FECHA_EXPEDICION_USU", oUsuarios.FECHA_EXPEDICION_USU);
                cmd.Parameters.AddWithValue("NOMBRE_USU", oUsuarios.NOMBRE_USU);
                cmd.Parameters.AddWithValue("APELLIDOS_USU", oUsuarios.APELLIDOS_USU);
                cmd.Parameters.AddWithValue("CELULAR_USU", oUsuarios.CELULAR_USU);
                cmd.Parameters.AddWithValue("GENERO_USU", oUsuarios.GENERO_USU);
                cmd.Parameters.AddWithValue("ID_CIUDAD_FK", oUsuarios.ID_CIUDAD_FK);
                cmd.Parameters.AddWithValue("DIRECCION_USU", oUsuarios.DIRECCION_USU);
                cmd.Parameters.AddWithValue("CORREO_ELECTRONICO_USU", oUsuarios.CORREO_ELECTRONICO_USU);
                cmd.Parameters.AddWithValue("CONTRASENA_USU", oUsuarios.CONTRASENA_USU);
                cmd.Parameters.Add("REGISTRADO", SqlDbType.Bit).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("MENSAJE", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                cmd.ExecuteNonQuery();

                /*LEER PARAMETROS DE SALIDA*/
                registrado = Convert.ToBoolean(cmd.Parameters["REGISTRADO"].Value);
                mensaje = cmd.Parameters["MENSAJE"].Value.ToString();
            }


            ViewData["MENSAJE"] = mensaje;

            if (registrado)
            {
                return RedirectToAction("Login", "Acceso");
            }
            else
            {
                return View();
            }
        }

        /*METODO INICIAR SESION*/
        [HttpPost]
        public ActionResult Login(Usuario oUsuarios)
        {
            /*ENCRIPTANDO CONTRASEÑA*/
            oUsuarios.CONTRASENA_USU = ConvertirSha256(oUsuarios.CONTRASENA_USU);

            /*CONECTANDO BASE DE DATOS*/
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                /*PROCEDIMIENTO ALMACENADO VALIDAR USUARIO*/
                SqlCommand cmd = new SqlCommand("VALIDAR_USUARIO", cn);
                cmd.Parameters.AddWithValue("CORREO_ELECTRONICO_USU", oUsuarios.CORREO_ELECTRONICO_USU);
                cmd.Parameters.AddWithValue("CONTRASENA_USU", oUsuarios.CONTRASENA_USU);
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();

                /*LEER IDENTIFICACION DEL USUARIO (PRIMERA FILA)*/
                oUsuarios.N_IDENTIFICACION_USU = cmd.ExecuteScalar().ToString();
            }

            /*ACCESO A VISTAS*/
            if (oUsuarios.N_IDENTIFICACION_USU != "0")
            {
                FormsAuthentication.SetAuthCookie(oUsuarios.N_IDENTIFICACION_USU, false);
                Session["Usuario"] = oUsuarios;
                return RedirectToAction("IndexUsuarios", "Servicios");
            }
            else
            {
                ViewData["MENSAJE"] = "Usuario no encontrado";
            }
            return View();
        }

        /*METODO PARA CERRAR SESION*/
        public ActionResult CerrarSesion()
        {
            FormsAuthentication.SignOut();
            Session["Usuario"] = null;
            return RedirectToAction("Index", "Home");
        }

        /*METODO ENCRIPTAR CONTRASEÑA*/
        public static string ConvertirSha256(string texto)
        {
            StringBuilder Sb = new StringBuilder();
            using (SHA256 hash = SHA256Managed.Create())
            {
                Encoding enc = Encoding.UTF8;
                byte[] result = hash.ComputeHash(enc.GetBytes(texto));
                foreach (byte b in result)
                    Sb.Append(b.ToString("x2"));
            }
            return Sb.ToString();
        }
    }
}