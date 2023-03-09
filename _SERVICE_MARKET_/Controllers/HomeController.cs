using _SERVICE_MARKET_.Models;
using System.Collections.Generic;
using System.Web.Mvc;

namespace _SERVICE_MARKET_.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            return View(ma.ConsultarServicios());
        }

        public ActionResult PreguntasFrecuentes()
        {
            return View();
        }

        public ActionResult PQR()
        {
            return View();
        }

        public ActionResult Buscar(string NOMBRE_SER)
        {
            MantenimientoServicios ma = new MantenimientoServicios();
            List<Servicio> lista = ma.BuscarServicios(NOMBRE_SER);
            return View(lista);
        }

        public ActionResult Categorias()
        { 
            return View();
        }
    }
}