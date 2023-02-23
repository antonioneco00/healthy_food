<?php

namespace App\Controller;

use App\Repository\RecipeRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class RecipeController extends AbstractController
{
    #[Route('/recipes', name: 'recipes')]
    public function index(RecipeRepository $recipeRepository): Response
    {
        $recipes = $recipeRepository->findAll();
        
        // dd($recipes[0]);
        
        return $this->render('recipe/index.html.twig', [
            'recipes' => $recipes
        ]);
    }
}
