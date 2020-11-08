<?php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use App\Repository\OrderDetailRepository;
use Doctrine\ORM\Mapping as ORM;
use App\Entity\Product;

/**
 * @ApiResource()
 * @ORM\Entity(repositoryClass=OrderDetailRepository::class)
 */
class OrderDetail
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=product::class, inversedBy="orderDetails")
     * @ORM\JoinColumn(nullable=false)
     */
    private $product;

    /**
     * @ORM\ManyToOne(targetEntity=order::class, inversedBy="orderDetails")
     * @ORM\JoinColumn(nullable=false)
     */
    private $parent_order;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getProduct(): ?Product
    {
        return $this->product;
    }

    public function setProduct(?Product $product): self
    {
        $this->product = $product;

        return $this;
    }

    public function getParentOrder(): ?Order
    {
        return $this->parent_order;
    }

    public function setParentOrder(?Order $parent_order): self
    {
        $this->parent_order = $parent_order;

        return $this;
    }
}
