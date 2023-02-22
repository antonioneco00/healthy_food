<?php
    
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route("/")]
class DefaultController extends AbstractController {

    #[Route("/")]
    public function home(): Response
    {
        return $this->render("public/home.html.twig");
    }

}