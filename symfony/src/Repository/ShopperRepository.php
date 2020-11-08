<?php

namespace App\Repository;

use App\Entity\Shopper;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Shopper|null find($id, $lockMode = null, $lockVersion = null)
 * @method Shopper|null findOneBy(array $criteria, array $orderBy = null)
 * @method Shopper[]    findAll()
 * @method Shopper[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ShopperRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Shopper::class);
    }

    public function getOrdersByShopperAndShop($shopper_id) {
        $conn = $this->getEntityManager()->getConnection();

        $sql = 'select *
        from exercise_lm.product p
        inner join exercise_lm.order_detail od on p.id = od.product_id
        left join exercise_lm.order o on od.parent_order_id = o.id
        where p.shop_id in (select shop_id from exercise_lm.shopper where id = :shopper_id)
        and o.completed = 0';
        $stmt = $conn->prepare($sql);
        $stmt->execute(array('shopper_id' => $shopper_id));

        return $stmt->fetchAll();
    }
}
