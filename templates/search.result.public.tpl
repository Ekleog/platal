<td>
  <strong>{$result.nom} {$result.prenom}</strong>
  {if $result.epouse neq ""}
    <div>({$result.epouse} {$result.prenom})</div>
  {/if}
  {if $result.decede == 1}
    <div>(d�c�d�)</div>
  {/if}
</td>
<td>
  (X {$result.promo})
</td>
