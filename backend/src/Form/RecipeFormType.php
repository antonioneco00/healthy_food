<?php

namespace App\Form;

use App\Entity\Recipe;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;

class RecipeFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', TextType::class, [
                'attr' => [
                    'placeholder' => 'Introduzca el nombre',
                    'class' => 'd-block w-50'
                ]
            ])
            ->add('photo', TextType::class, [
                'attr' => [
                    'placeholder' => 'Introduzca la url a una imagen',
                    'class' => 'd-block w-50'
                ]
            ])
            ->add('description', TextareaType::class, [
                'attr' => [
                    'placeholder' => 'Añade una descripcion',
                    'class' => 'd-block w-50'
                ]
            ])
            ->add('preparation', TextareaType::class, [
                'attr' => [
                    'placeholder' => 'Indique su preparacion',
                    'class' => 'd-block w-50'
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Recipe::class,
        ]);
    }
}
