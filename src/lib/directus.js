import { createDirectus, authentication } from '@directus/sdk';
import { PUBLIC_DIRECTUS_URL } from '$env/static/public';

export default createDirectus(PUBLIC_DIRECTUS_URL).with(authentication('cookie', {
  autoRefresh: true,
}));