{*
*
* Template to include on hook footer front-end; passes module options to javascript function
* @package Infinite_Scroll
*}
<script type="text/javascript">
	infinite_scroll = {$options};
	{if isset($pages_nb)}
	infinite_scroll.maxPage = {$pages_nb};
	{/if}
	jQuery( infinite_scroll.contentSelector ).infinitescroll( infinite_scroll, function(newElements, data, url) { eval(infinite_scroll.callback); });
</script>