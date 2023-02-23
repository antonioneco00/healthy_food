<?php

namespace App\DataFixtures;

use App\Entity\Recipe;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $recipe = new Recipe();
        $recipe->setName('Tortilla');
        $recipe->setPhoto('https://cdn.pixabay.com/photo/2015/05/20/16/11/kitchen-775746_1280.jpg');
        $recipe->setDescription('Descripcion de la tortilla');
        $recipe->setPreparation('Preparacion de la tortilla');

        $manager->persist($recipe);

        $recipe2 = new Recipe();
        $recipe2->setName('Salmon');
        $recipe2->setPhoto('https://cdn.pixabay.com/photo/2014/11/05/15/57/salmon-518032_1280.jpg');
        $recipe2->setDescription('Descripcion del salmon');
        $recipe2->setPreparation('Preparacion del salmon');
        
        $manager->persist($recipe2);

        $manager->flush();
    }
}
