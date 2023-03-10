using _SERVICE_MARKET_.Models;
using System.Collections.Generic;
using System.Web.Mvc;

namespace _SERVICE_MARKET_.Controllers
{
    [Authorize]
    public class ServiciosController : Controller
    {
        // USUARIOS
        public ActionResult IndexUsuarios()
        {
            return View();
        }

        public ActionResult PreguntasFrecuentes()
        {
            return View();
        }

        public ActionResult PQR()
        {
            return View();
        }
    

        //SECCIÓN CLIENTE

        public ActionResult ServiciosDisponiblesCliente()
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            return View(ma.ConsultarServicios());
        }

        public ActionResult BuscarCliente(string NOMBRE_SER)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            List<Servicio> lista = ma.BuscarServicios(NOMBRE_SER);
            return View(lista);
        }

        public ActionResult PublicarSolicitud()
        {
            return View();
        }

        [HttpPost]
        public ActionResult PublicarSolicitud(FormCollection collection)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            Servicio oServicios = new Servicio
            {
                NOMBRE_SER = collection["NOMBRE_SER"],
                PRECIO_SER = decimal.Parse(collection["PRECIO_SER"].ToString()),
                DESCRIPCION_BREVE = collection["DESCRIPCION_BREVE"],
                TERMINOS_SER = collection["TERMINOS_SER"],
                TIPO = "Solicitud",
                N_IDENTIFICACION_USU_FK = collection["N_IDENTIFICACION_USU_FK"],
                ID_CATEGORIA_FK = int.Parse(collection["ID_CATEGORIA_FK"])
            };
            ma.AgregarServicio(oServicios);
            return RedirectToAction("ServiciosDisponiblesCliente");
        }

        public ActionResult InformacionPublicaciones(int ID)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            Servicio ser = ma.InformacionPublicacion(ID);
            return View(ser);
        }



        //SECCIÓN PRESTADOR DE SERVICIOS
        public ActionResult ServiciosDisponiblesPrestador()
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            return View(ma.ConsultarSolicitudes());
        }
        public ActionResult BuscarPrestador(string NOMBRE_SER)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            List<Servicio> lista = ma.BuscarSolicitudes(NOMBRE_SER);
            return View(lista);
        }

        public ActionResult PublicarServicio()
        {
            return View();
        }

        [HttpPost]
        public ActionResult PublicarServicio(FormCollection collection)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            Servicio oServicios = new Servicio
            {
                NOMBRE_SER = collection["NOMBRE_SER"],
                PRECIO_SER = decimal.Parse(collection["PRECIO_SER"].ToString()),
                DESCRIPCION_BREVE = collection["DESCRIPCION_BREVE"],
                TERMINOS_SER = collection["TERMINOS_SER"],
                TIPO = "Publicacion",
                N_IDENTIFICACION_USU_FK = collection["N_IDENTIFICACION_USU_FK"],
                ID_CATEGORIA_FK = int.Parse(collection["ID_CATEGORIA_FK"])
            };
            ma.AgregarServicio(oServicios);
            return RedirectToAction("ServiciosDisponiblesPrestador");
        }

        public ActionResult InformacionSolicitudes(int ID)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            Servicio ser = ma.InformacionSolicitud(ID);
            return View(ser);
        }

    }
}