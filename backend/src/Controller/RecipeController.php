<?php

namespace App\Controller;

use App\Entity\Recipe;
use App\Form\RecipeFormType;
use App\Repository\RecipeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class RecipeController extends AbstractController
{
    private $recipeRepository;
    private $entityManager;

    public function __construct(RecipeRepository $recipeRepository, EntityManagerInterface $entityManager)
    {
        $this->recipeRepository = $recipeRepository;
        $this->entityManager = $entityManager;
    }

    #[Route('/recipes', name: 'recipes', methods: ['GET'])]
    public function index(): Response
    {
        $recipes = $this->recipeRepository->findAll();

        return $this->render('recipe/index.html.twig', [
            'recipes' => $recipes
        ]);
    }

    #[Route('/recipe/{id}', name: 'detail', methods: ['GET'])]
    public function detail($id): Response
    {
        $recipe = $this->recipeRepository->find($id);

        return $this->render('recipe/detail.html.twig', [
            'recipe' => $recipe
        ]);
    }

    #[Route('/recipe/create', name: 'create', methods: ['GET', 'POST'])]
    public function create(Request $request): Response
    {
        $recipe = new Recipe();
        $form = $this->createForm(RecipeFormType::class, $recipe);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $recipeData = $form->getData();

            $this->entityManager->persist($recipeData);
            $this->entityManager->flush();

            return $this->redirectToRoute('recipes');
        }

        return $this->render('recipe/create.html.twig', [
            'form' => $form->createView()
        ]);
    }

    #[Route('/recipe/edit/{id}', name: 'edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, $id): Response
    {
        $recipe = $this->recipeRepository->find($id);
        $form = $this->createForm(RecipeFormType::class, $recipe);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $recipe->setName($form->get('name')->getData());
            $recipe->setPhoto($form->get('photo')->getData());
            $recipe->setDescription($form->get('description')->getData());
            $recipe->setPreparation($form->get('preparation')->getData());

            $this->entityManager->persist($recipe);
            $this->entityManager->flush();

            return $this->redirectToRoute('recipes');
        }

        return $this->render('recipe/edit.html.twig', [
            'recipe' => $recipe,
            'form' => $form->createView()
        ]);
    }

    #[Route('/recipe/delete/{id}', name: 'delete', methods: ['GET', 'DELETE'])]
    public function delete($id): Response
    {
        $recipe = $this->recipeRepository->find($id);
        $form = $this->createForm(RecipeFormType::class, $recipe);

        $this->entityManager->remove($recipe);
        $this->entityManager->flush();
        
        return $this->redirectToRoute('recipes');
    }
}
