using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("[controller]")]
public class PingController : ControllerBase
{
    [HttpGet]
    public IActionResult Get() => Ok("Pong!");

    [Authorize]
    [HttpGet("secure")]
    public IActionResult GetSecure() => Ok("This is a secure pong 🛡️");
}
