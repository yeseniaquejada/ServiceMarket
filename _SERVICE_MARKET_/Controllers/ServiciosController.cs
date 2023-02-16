using _SERVICE_MARKET_.Models;
using System.Collections.Generic;
using System.Web.Mvc;

namespace _SERVICE_MARKET_.Controllers
{
    public class ServiciosController : Controller
    {
        // USUARIOS
        public ActionResult IndexUsuarios()
        {
            return View();
        }

        public ActionResult preguntasFrecuentes()
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
                TIPO = collection["TIPO"],
                N_IDENTIFICACION_USU_FK = collection["N_IDENTIFICACION_USU_FK"],
                ID_CATEGORIA_FK = int.Parse(collection["ID_CATEGORIA_FK"])
            };
            ma.AgregarServicio(oServicios);
            return RedirectToAction("ServiciosDisponiblesCliente");
        }

        public ActionResult BuscarSerCliente(string NOMBRE_SER)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            List<Servicio> lista = ma.BuscarServicios(NOMBRE_SER);
            return View(lista);
        }



        //SECCIÓN PRESTADOR DE SERVICIOS

        public ActionResult ServiciosDisponiblesPrestador()
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            return View(ma.ConsultarServicios());
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
                TIPO = collection["TIPO"],
                N_IDENTIFICACION_USU_FK = collection["N_IDENTIFICACION_USU_FK"],
                ID_CATEGORIA_FK = int.Parse(collection["ID_CATEGORIA_FK"])
            };
            ma.AgregarServicio(oServicios);
            return RedirectToAction("ServiciosDisponiblesPrestador");
        }






        public ActionResult informacionPublicaciones(int ID)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            Servicio ser = ma.Informacion_Servicios(ID);
            return View(ser);
        }
        public ActionResult BuscarSer(string NOMBRE_SER)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            List<Servicio> lista = ma.BuscarServicios(NOMBRE_SER);
            return View(lista);
        }
    }
}